FROM ruby:3.2.2

# Install dependencies
RUN apt-get update -qq && \
    apt-get install -y sqlite3 libsqlite3-dev curl gnupg && \
    # Add NodeSource repository for Node.js 18.x
    mkdir -p /etc/apt/keyrings && \
    curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg && \
    echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_18.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list && \
    apt-get update && \
    apt-get install -y nodejs && \
    # Install Yarn
    npm install -g yarn

# Set working directory
WORKDIR /app

# Add Gemfile and install dependencies
COPY Gemfile Gemfile.lock ./
RUN gem install bundler -v 2.6.5
RUN bundle install

# Install JavaScript dependencies
COPY package.json yarn.lock ./
RUN yarn install --check-files

# Copy application code
COPY . .

# Precompile assets
RUN bundle exec rails webpacker:compile

# Add a script to be executed every time the container starts
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

# Configure the main process to run when running the image
EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
