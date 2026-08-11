# Use Ruby 3.3.7
ARG RUBY_VERSION=3.3.7
FROM ruby:$RUBY_VERSION-slim

# Rails app lives here
WORKDIR /rails

# Install system packages needed to build native gems (e.g. mysql2) and to run
# the app. build-essential + default-libmysqlclient-dev are required so that
# `bundle install` can compile the mysql2 native extension.
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential ca-certificates default-mysql-client default-libmysqlclient-dev git libyaml-dev pkg-config && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Copy the Gemfile so it is present in the image. Gems themselves are installed
# at container start-up (see docker-compose.yml) into a persistent volume, not
# baked into the image. This keeps image builds fast and reliable (no network
# fetch of gems during `docker build`) which matters a lot on flaky connections,
# and it fits the bind-mounted dev workflow where the source is mounted from the
# host at runtime.
COPY Gemfile Gemfile.lock ./

# Copy application code
COPY . .

# Entrypoint prepares the database
ENTRYPOINT ["/rails/bin/docker-entrypoint"]

# Start the server by default
EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
