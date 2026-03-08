FROM ruby:3.3-slim

RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
      build-essential \
      libpq-dev \
      libyaml-dev \
      postgresql-client \
      curl \
      git && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install --jobs 4 --retry 3

COPY . .

EXPOSE 3001

CMD ["bundle", "exec", "rails", "server", "-p", "3001", "-b", "0.0.0.0"]
