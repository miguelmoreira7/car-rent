# Use the official Ruby image with the specified version as the base image
ARG RUBY_VERSION=3.3.7
FROM docker.io/library/ruby:$RUBY_VERSION-slim AS base

# Set working directory for the Rails app
WORKDIR /rails

# Install necessary system dependencies
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    curl \
    libjemalloc2 \
    libvips \
    sqlite3 \
    libyaml-dev \
    build-essential \
    git \
    pkg-config && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Set environment variables for production
ENV RAILS_ENV="production" \
    BUNDLE_DEPLOYMENT="1" \
    BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITHOUT="development"

# First build stage to install application dependencies
FROM base AS build

# Copy the Gemfile and Gemfile.lock to install gems
COPY Gemfile Gemfile.lock ./

# Install the application gems
RUN bundle install && \
    rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git && \
    bundle exec bootsnap precompile --gemfile

# Copy the application code
COPY . .

# Precompile bootsnap code for faster boot times
RUN bundle exec bootsnap precompile app/ lib/

# Adjust the binfiles to be executable on Linux and fix CRLF issues
RUN chmod +x bin/* && \
    sed -i "s/\r$//g" bin/* && \
    sed -i 's/ruby\.exe$/ruby/' bin/*

# Precompile assets for production (without requiring secret RAILS_MASTER_KEY)
RUN SECRET_KEY_BASE_DUMMY=1 ./bin/rails assets:precompile

# Final stage: Create the runtime image
FROM base AS final

# Copy installed gems and app code from the build stage
COPY --from=build "${BUNDLE_PATH}" "${BUNDLE_PATH}"
COPY --from=build /rails /rails

# Create and set non-root user for security
RUN groupadd --system --gid 1000 rails && \
    useradd rails --uid 1000 --gid 1000 --create-home --shell /bin/bash && \
    chown -R rails:rails db log storage tmp

USER 1000:1000

# Set the entrypoint to initialize the database and run Rails server
ENTRYPOINT ["/rails/bin/docker-entrypoint"]

# Expose port 80 for the Rails app
EXPOSE 80

# Start the Rails server via Thruster by default, can be overwritten at runtime
CMD ["./bin/thrust", "./bin/rails", "server"]
