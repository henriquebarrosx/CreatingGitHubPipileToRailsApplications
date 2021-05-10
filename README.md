# Learning how write TDD in Rails

This project has the simples objective to teach how write test using 
Ruby and how use Github Actions to build a CI flow to improve the test 
experience.

- Ruby version: 3.0.0
- Rspec version: 3.9.0
- Shoulda-Matchers version: ~4.0

## Dependencies
### Postgres
```bash
# Bash

sudo apt install postgresql postgresql-contrib
gem install pg

```

### Rspec

```ruby
# Gemfile

group :development, :test do
  gem 'rspec-rails', ">= 3.9.0"
end
```

```bash
# Bash

rails generate rspec:install
```

### Shoulda Matchers

```ruby
# Gemfile 

group :development, :test do
  gem 'shoulda-matchers', '~> 4.0'
end
```

```ruby
# spec/rails_helper.rb

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
```

## Setting up Github actions
```yaml
# Create the file /.github/workflows/ruby.yml

name: Ruby

on:
  # Define witch branch you want to run the CI after push / PR
  push:
    branches: [main] 
  pull_request:
    branches: [main]

jobs:
  tests:
    name: Project CI
    runs-on: ubuntu-latest

    # Defining services like Postgres, Redis or Webpack
    services:
      postgres:
        image: postgres:11
        # Postgres service setup
        env:
          POSTGRES_DB: rails_tdd_test
          POSTGRES_USER: postgres
          POSTGRES_PASSWORD: postgres
        ports: ['5432:5432']
        options: >-
          --health-cmd pg_isready
          --health-interval 10s
          --health-timeout 5s
          --health-retries 5
    steps:
      - name: Checkout code
        uses: actions/checkout@v2

      - name: Setup Ruby
        uses: ruby/setup-ruby@v1
        with:
          # Specify ruby version
          ruby-version: 3.0.0
          # Add cache to make CI more faster
          bundler-cache: true

      - name: Install dependencies
        run: |
          sudo apt-get -yqq install libpq-dev build-essential libcurl4-openssl-dev postgresql postgresql-contrib
          gem install pg
          bundle install --jobs 4 --retry 3
      
      # Add env variables to run test configuration
      - name: Running Rspec tests 
        env:
          RAILS_ENV: test
          PGHOST: localhost
          DATABASE: rails_tdd_test
          POSTGRES_USER: postgres
          POSTGRES_PASSWORD: postgres
          
        # Running Rspec tests
        run: |
          bundle exec rails db:schema:load
          bundle exec rspec --format progress

```


## Getting started
```bash
bundle install

rails dev:cache

rake db:create

rake db:migrate

rspec # To run the tests
```