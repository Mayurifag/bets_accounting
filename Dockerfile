FROM ruby:2.5.3

RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends \
                    build-essential apt-transport-https apt-utils postgresql-client && \
    rm -rf /var/lib/apt/lists/*

RUN curl -sL https://deb.nodesource.com/setup_9.x | bash -
RUN apt-get install -qq -y nodejs
RUN apt-get update -qq && apt-get install -y yarn
RUN npm install -g yarn

WORKDIR /usr/src/app

# we need ruby-verion because its used in gemfile
COPY .ruby-version ./
COPY Gemfile* ./
RUN gem install bundler
RUN bundle install --without ci

COPY package.json /usr/src/app/package.json
COPY yarn.lock /usr/src/app/yarn.lock
RUN yarn install -f

COPY . .
