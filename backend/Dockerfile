FROM ruby:2.6.4-alpine

WORKDIR /usr/src/app

COPY Gemfile* ./
COPY .ruby-version ./

# build-base, xz-dev -- nokogiri
# git - to update bundler audit
# postgresql-dev - pg
# tzdata - tzinfo-data to prevent TZInfo::DataSourceNotFound: tzinfo-data is not present on rails db create/migrate/etc.
RUN apk add --update --no-cache \
  build-base \
  git \
  postgresql-dev \
  tzdata \
  xz-dev \
  && bundle install -j3 --path vendor/bundle

COPY . .

CMD ["bundle", "exec", "rails", "server", "-p", "8080", "-b", "0.0.0.0"]
