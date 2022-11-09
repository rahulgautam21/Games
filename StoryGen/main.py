from fastapi import FastAPI
import uvicorn
import openai
import random

# This is not committed to git for safety feel free to create a config.py and store the
from config import openai_access_token

# Cohesion libraries
from cohesion import *


app = FastAPI()
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
    return word_dist_cohesion(text)


if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8000)
