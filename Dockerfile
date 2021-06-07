FROM ruby:2.6.5

RUN apt-get update && apt-get install -y --no-install-recommends \
    nodejs \
    mariadb-client \
    build-essential \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
WORKDIR /crowd_funding

COPY Gemfile /crowd_funding/Gemfile
COPY Gemfile.lock /crowd_funding/Gemfile.lock

RUN gem install bundler
RUN bundle install

COPY . /crowd_funding