# Use a smaller base image for production
FROM ruby:3.2.2-slim

# Set the working directory
WORKDIR /app

# Install required system dependencies
RUN apt-get update -qq && apt-get install -y \
    build-essential \
    libpq-dev \
    nodejs \
    yarn \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copy gem files and install gems
COPY Gemfile Gemfile.lock ./
RUN bundle install --jobs 4 --retry 3

# Copy the application source code
COPY . .

# Precompile assets
RUN bundle exec rake assets:precompile

# Expose the application port
EXPOSE 3000

# Start the Rails server
CMD ["rails", "server", "-b", "0.0.0.0", "-p", "3000"]
