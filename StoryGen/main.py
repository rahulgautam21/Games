from fastapi import FastAPI
import uvicorn
import openai
import random
# This is not committed to git for safety feel free to create a config.py and store the
from config import openai_access_token
# Cohesion libraries
from cohesion import *
import psycopg2
from psycopg2.extras import DictCursor
from pydantic import BaseModel
from fastapi.middleware.cors import CORSMiddleware
from sentence_splitter import SentenceSplitter, split_text_into_sentences
from imageio import imread, imwrite
from PIL import ImageDraw
from PIL import Image, ImageFont
import requests
from urllib.request import urlopen
import base64
import numpy as np
import math
from io import BytesIO
from fastapi import Response
import spacy
import neuralcoref

nlp = spacy.load('en_core_web_sm')
neuralcoref.add_to_pipe(nlp)

splitter = SentenceSplitter(language='en')

TINT_COLOR = (255, 255, 255)  # White
TRANSPARENCY = .25  # Degree of transparency, 0-100%
OPACITY = int(255 * TRANSPARENCY)

conn = psycopg2.connect(database="postgres",
                        host="localhost",
                        user="postgres",
                        password="admin",
                        port="5432")

app = FastAPI()
app.add_middleware(
    CORSMiddleware,
    allow_methods=["*"],
    allow_origins=['*']
)
openai.api_key = openai_access_token
completion = openai.Completion()

hero_villain = [
    {
        'hero': 'Gandalf',
        'villain': 'Saruman'
    },
    {
        'hero': 'Luke Skywalker',
        'villain': 'Darth Vader'
    },
    {
        'hero': 'Professor X',
        'villain': 'Magneto'
    },
    {
        'hero': 'Wolverine',
        'villain': 'Sabertooth'
    },
    {
        'hero': 'Harry Potter',
        'villain': 'Lord Voldemort'
    },
    {
        'hero': 'Neo',
        'villain': 'Agent Smith'
    },
    {
        'hero': 'Batman',
        'villain': 'The Joker'
    },
    {
        'hero': 'Thor',
        'villain': 'Loki'
    },
    {
        'hero': 'Sherlock Holmes',
        'villain': 'Jim Moriarty'
    },
    {
        'hero': 'Superman',
        'villain': 'Lex Luthor'
    },
    {
        'hero': 'Optimus Prime',
        'villain': 'Megatron'
    },
    {
        'hero': 'Iron Man',
        'villain': 'Thanos'
    },
    {
        'hero': 'Spiderman',
        'villain': 'Green Goblin'
    },
    {
        'hero': 'James Bond',
        'villain': 'Goldfinger'
    },
    {
        'hero': 'Naruto',
        'villain': 'Sasuke'
    },
    {
        'hero': 'Edward',
        'villain': 'Jacob'
    },
]

cities = ['Asgard', 'London', 'New York', 'Paris', 'Hogwarts', 'Village', 'North Carolina', 'Raleigh', 'Mumbai',
          'Pakistan', 'Tokyo', 'Washington DC', 'Helsinki']


def gpt_gen(prefix, suffix):
    # len_prompt = len(prefix.split()) + len(suffix.split())
    max_tokens = 10
    ret_val = []
    response = openai.Completion.create(
        prompt=prefix,
        suffix=suffix,
        model='text-davinci-003',
        max_tokens=max_tokens,
        frequency_penalty=1,
        presence_penalty=1,
        n=3,
        temperature=0.4)
    print(response)
    for i in range(len(response.choices)):
        text = response.choices[i].text
        if text != '':
            ret_val.append(text)
    return ret_val


@app.get('/getChoices')
def get_choices(start_prompt: str, end_prompt: str):
    return gpt_gen(start_prompt, end_prompt)


@app.get('/getImage')
def get_image(story: str):
    response = openai.Image.create(
        prompt=story,
        n=1,
        size="1024x1024"
    )
    image_url = response['data'][0]['url']
    return image_url


@app.get('/getSetting')
def get_setting():
    ans = random.choice(hero_villain)
    ans['location'] = random.choice(cities)
    return ans


# API call to get cohesion metrics
@app.get('/getCohesion')
def get_cohesion(text: str):
    """
    :param text: a string of sentences
    :return: Word dist cohesion score
    """
    return word_dist_cohesion(Document(text))


# API call to get all story titles
@app.get('/titles')
def get_titles():
    titles = []
    with conn.cursor(cursor_factory=DictCursor) as curs:
        curs.execute("SELECT row_to_json(row) FROM (SELECT title FROM story) row;")
        results = curs.fetchall()
        for result in results:
            titles.append(result[0]['title'])
    return titles


# API call to get story based on title
@app.get('/story')
def get_story(title: str):
    ans = {}
    cursor = conn.cursor()
    try:
        cursor.execute("SELECT row_to_json(row) FROM (SELECT * FROM story where title='" + title.replace("'", "''")
                       + "') row;")
        results = cursor.fetchone()
        ans = results[0]
    except psycopg2.Error as e:
        print(e)
        conn.rollback()
    cursor.close()
    return ans


class Story(BaseModel):
    title: str
    text: str
    hero: str
    villain: str
    location: str


# API call to save story
@app.post('/story')
def save_story(story: Story):
    ans = ""
    cursor = conn.cursor()
    try:
        cursor.execute('INSERT INTO story (title, text, hero, villain, location) VALUES (%s, %s, %s, %s, %s) '
                       'ON CONFLICT (title) DO UPDATE SET (text, hero, villain, location) = (EXCLUDED.text,'
                       ' EXCLUDED.hero,EXCLUDED.villain, EXCLUDED.location)',
                       (story.title, story.text, story.hero, story.villain, story.location))
        conn.commit()
        ans = "Successfully Saved"
    except psycopg2.Error as e:
        print(e)
        conn.rollback()
        ans = "Could not save " + str(e.pgerror)
    cursor.close()
    return ans


def multiline_sentence(text):
    line_length = 50
    count = 0
    new_text = ''

    for word in text.split():
        if count + len(word) + 1 > line_length:
            count = 0
            new_text += '\n'

        new_text += ' ' + word
        count += len(word) + 1

    return new_text


def image_generator(text):
    sentences = splitter.split(text=text)
    return_sentences = []
    # Replacing pronoun with nouns
    doc = nlp(text)
    replaced_sentences = splitter.split(text=doc._.coref_resolved)
    urls = []

    for sentence in replaced_sentences:
        if sentence.strip() == '':
            continue
        response = openai.Image.create(
            prompt=sentence,
            n=1,
            size="512x512"
        )
        image_url = response['data'][0]['url']
        urls.append(image_url)

    im = Image.new(mode="RGB", size=(512, 512))

    for idx in range(len(sentences)):
        if sentences[idx].strip() == '':
            continue
        return_sentences.append(multiline_sentence(sentences[idx]))

    return return_sentences, urls, im


@app.get('/comic', responses={
    200: {
        "content": {"image/png": {}}
    }
},
         response_class=Response
         )
def get_comic(story: str):
    sentences, urls, black_image = image_generator(story)
    url_length = len(urls)
    rows = math.ceil(url_length / 4)
    v_stack = []
    font = ImageFont.truetype("OpenSans-Regular.ttf", size=20)

    for i in range(rows):
        image_arr = []

        for j in range(4):
            index = 4 * i + j
            if index < url_length:
                img = Image.open(urlopen(urls[index]))
                draw = ImageDraw.Draw(img, "RGBA")
                draw.rectangle(((10, 400), (502, 500)), fill=(200, 100, 0, 127))
                draw.rectangle(((10, 400), (502, 500)), outline=(0, 0, 0, 127), width=3)
                draw.multiline_text((15, 410), sentences[index], (0, 0, 0),  # Color
                                    font=font)
                # print(np.array(img).shape)
                image_arr.append(img)

            else:
                img = black_image
                # print(np.array(img).shape)
                image_arr.append(img)

        cstrip = np.hstack((image_arr))
        v_stack.append(cstrip)

    result = np.vstack(v_stack)
    data = result.copy()

    image_out = Image.fromarray(data)

    # save image to an in-memory bytes buffer
    with BytesIO() as buf:
        image_out.save(buf, format='PNG')
        im_bytes = buf.getvalue()

    headers = {'Content-Disposition': 'inline; filename="test.png"'}
    return Response(im_bytes, headers=headers, media_type='image/png')


if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8000)

# if __name__ == '__main__':
#     Popen(['python', '-m', 'https_redirect'])  # Add this
#     uvicorn.run(
#         'main:app', port=8432, host='0.0.0.0',
#         reload=True, reload_dirs=['html_files'],
#         ssl_keyfile='/home/rgautam3/Desktop/Games-main/StoryGen/privatekey.pem',
#         ssl_certfile='/home/rgautam3/Desktop/Games-main/StoryGen/certificate.pem')

