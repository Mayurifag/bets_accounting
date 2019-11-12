FROM ruby:${RUBY_VERSION:-2.6.3-alpine}

ENV LANG=C.UTF-8 \
    GEM_HOME=/bundle \
    BUNDLE_JOBS=4 \
    BUNDLE_RETRY=3 \
    BUNDLE_PATH=/bundle \
    BUNDLE_APP_CONFIG=/bundle \
    BUNDLE_BIN=/bundle/bin \
    PATH=/usr/src/app/backend/bin:/bundle/bin:$PATH

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
  ;

WORKDIR /usr/src/app

COPY . .
