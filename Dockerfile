FROM ruby:3.1.4-alpine AS build
RUN ["apk", "add", "--no-cache", \
     "build-base", \
     "gcompat", \
     "postgresql-client", \
     "postgresql-dev", \
     "shared-mime-info", \
     "tzdata"]
COPY Gemfile Gemfile.lock ./
RUN  ["bundle", "config", "build.nokogiri", "--use-system-libraries"]
RUN  ["bundle", "install", "--system", "--no-cache"]

FROM    ruby:3.1.4-alpine
RUN     ["apk", "add", "--no-cache", "gcompat", "less", "postgresql-client", "shared-mime-info", "tzdata"]
ENV     APP_ROOT=/app
WORKDIR ${APP_ROOT}
COPY    --from=build /usr/local/bundle /usr/local/bundle
COPY    . .

CMD ["bin/rails", "s", "-p", "3000", "-b", "0.0.0.0"]
