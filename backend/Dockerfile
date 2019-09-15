FROM ruby:${RUBY_VERSION:-2.6.3}-alpine

ENV LANG=C.UTF-8 \
    GEM_HOME=/bundle \
    BUNDLE_JOBS=4 \
    BUNDLE_RETRY=3
ENV BUNDLE_PATH $GEM_HOME
ENV BUNDLE_APP_CONFIG=$BUNDLE_PATH \
    BUNDLE_BIN=$BUNDLE_PATH/bin
ENV PATH /usr/src/app/backend/bin:$BUNDLE_BIN:$PATH

# build-base, xz-dev -- nokogiri
# git - to update bundler audit
# postgresql-dev - pg
# tzdata - tzinfo-data to prevent TZInfo::DataSourceNotFound: tzinfo-data is not present on rails db create/migrate/etc.
RUN apk add --update --no-cache \
  build-base \
  git \
  postgresql-dev \
  tzdata \
  xz-dev && \
  gem update --system && \
  gem install bundler

WORKDIR /usr/src/app

COPY . .
