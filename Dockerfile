#FROM ruby:2.4.1-slim
FROM ruby:2.4.1

RUN apt-get update -qq && apt-get install -y build-essential apt-utils

RUN mkdir -p /myapp
WORKDIR /myapp
COPY . /myapp

RUN bundle install
