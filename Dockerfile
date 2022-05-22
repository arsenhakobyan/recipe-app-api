#FROM python:3.9-alpine3.13
FROM python:3.9
LABEL maintainer="arsen"

ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /tmp/requirements.txt
COPY ./requirements.dev.txt /tmp/requirements.dev.txt
COPY ./app /app
WORKDIR /app
EXPOSE 8000

ARG DEV=false
#RUN python -m venv /py && \
#    /py/bin/pip install --upgrade pip && \
#    apk add --update --no-cache postgresql-client && \
#    apk add --update --no-cache --virtual .tmp-build-deps \
#    build-base postgresql-dev musl-dev &&\
#    /py/bin/pip install -vv -r /tmp/requirements.txt && \
#    if [ $DEV = "true" ]; \
#    then /py/bin/pip install -r /tmp/requirements.dev.txt ; \
#    fi && \
#    rm -rf /tmp && \
#    apk del .tmp-build-deps && \
#    adduser \
#    --disabled-password \
#    --no-create-home \
#    django-user

RUN pip install --upgrade pip
RUN apt update && apt upgrade -y
RUN apt install -y postgresql-client gcc musl-dev
#apt-get add --update --no-cache postgresql-client && \
#apt-get add --update --no-cache --virtual .tmp-build-deps \
#build-base postgresql-dev musl-dev &&\
RUN pip install -vv -r /tmp/requirements.txt && \
    if [ $DEV = "true" ]; \
    then pip install -r /tmp/requirements.dev.txt ; \
    fi && \
    rm -rf /tmp && \
    #apt-get del .tmp-build-deps && \
    adduser \
    --disabled-password \
    --no-create-home \
    django-user


ENV PATH="/py/bin:$PATH"

USER django-user