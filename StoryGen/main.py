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

conn = psycopg2.connect(database="postgres",
                        host="localhost",
                        user="postgres",
                        password="admin",
                        port="5432")

app = FastAPI()
app.add_middleware(
    CORSMiddleware,
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
        model='text-davinci-002',
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
    with conn.cursor(cursor_factory=DictCursor) as curs:
        curs.execute("SELECT row_to_json(row) FROM (SELECT * FROM story where title='" + title + "') row;")
        results = curs.fetchone()
        ans = results[0]
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

@app.get('/comic')
def get_comic(title: str):
    return None


if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8000)
