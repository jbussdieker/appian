FROM ruby:2.2.0
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /appian
WORKDIR /appian
ADD Gemfile /appian/Gemfile
ADD Gemfile.lock /appian/Gemfile.lock
RUN bundle install
ADD . /appian
