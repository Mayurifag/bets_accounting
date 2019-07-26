FROM ruby:2.6-alpine

WORKDIR /usr/src/app

COPY Gemfile* ./
COPY .ruby-version ./

# build-base, xz-dev -- nokogiri
# postgresql-dev - pg
# tzdata - tzinfo-data
RUN apk add --update --no-cache \
  build-base \
  postgresql-dev \
  tzdata \
  xz-dev \
  && bundle install -j3 --path vendor/bundle

COPY . .

CMD ["bundle", "exec", "rails", "server", "-p", "8080", "-b", "0.0.0.0"]
