FROM ubuntu:xenial

LABEL maintainer="Sudarsan Bhargavan"

WORKDIR /cowsay-app

ADD ./requirements.txt /cowsay-app/requirements.txt
ADD ./cowsay.py /cowsay-app/cowsay.py

RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get -y install cowsay python3 python3-pip
RUN python3 -m pip install --upgrade pip
RUN python3 -m pip install -r /cowsay-app/requirements.txt

ENV PATH="${PATH}:/usr/games"

EXPOSE 5000

ENTRYPOINT python3 /cowsay-app/cowsay.py
