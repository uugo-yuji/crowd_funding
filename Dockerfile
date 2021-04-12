FROM ruby:2.6.5

RUN apt-get update && apt-get install -y --no-install-recommends \
    nodejs \
    mariadb-client \
    build-essential \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
WORKDIR /portfolio_project

COPY Gemfile /portfolio_project/Gemfile
COPY Gemfile.lock /portfolio_project/Gemfile.lock

RUN gem install bundler
RUN bundle install

COPY . /portfolio_project