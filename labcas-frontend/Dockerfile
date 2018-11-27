FROM ubuntu:16.04

RUN apt-get update -y && \
    apt-get install -y python-pip python-dev && \
    pip install --upgrade pip setuptools

# We copy this file first to leverage docker cache
COPY ./pyramid_hello_world/requirements.txt /app/requirements.txt

WORKDIR /app

RUN pip install -r requirements.txt

COPY ./pyramid_hello_world /app

ENTRYPOINT [ "python" ]

CMD [ "app.py" ]
