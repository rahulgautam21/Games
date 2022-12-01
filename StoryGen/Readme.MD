Generated SSL certificates using:
https://linuxconfig.org/how-to-generate-a-self-signed-ssl-certificate-on-linux

Cohesion Score Generation Code taken from: https://github.com/ronxin/StickyText

To run the backend: 

Install requirements 

```
pip install -r requirements.txt

python main.py
```

This requires postgres for storing the stories.
To install postgres see https://www.postgresql.org/download/windows/

Create postgres tables using below:

```
-- Table: public.story

-- DROP TABLE IF EXISTS public.story;

CREATE TABLE IF NOT EXISTS public.story
(
    title text COLLATE pg_catalog."default" NOT NULL,
    text text COLLATE pg_catalog."default" NOT NULL,
    hero text COLLATE pg_catalog."default" NOT NULL,
    villain text COLLATE pg_catalog."default" NOT NULL,
    location text COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT story_pkey PRIMARY KEY (title)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.story
    OWNER to postgres;
```