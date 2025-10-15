# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby file: ".tool-versions"

gem "awesome_print"
gem "bootsnap", ">= 1.4.4", require: false
gem "devise"
gem "devise-i18n"
gem "devise-pwned_password"
gem "jquery-rails"
gem "jsonapi-serializer"
gem "lograge"
gem "pg", "~> 1.6"
gem "pry-rails"
gem "puma", "~> 7.0"
gem "pundit"
gem "rack-attack"
gem "rails", "~> 8.0.2"
gem "rails-i18n"
gem "rollbar"
gem "shakapacker", "9.2.0"
gem "sidekiq"
gem "tzinfo-data", platforms: [:windows, :jruby]

group :development, :test do
  gem "bullet"
  gem "byebug", platforms: [:mri, :windows]
  gem "dotenv-rails"
  gem "erb_lint", require: false
  gem "factory_bot_rails"
  gem "faker"
  gem "i18n-tasks"
  gem "rspec-rails", "~> 8.0.2"
  gem "selenium-webdriver", ">= 4.11"
  gem "shoulda-matchers"
end

group :development do
  gem "brakeman", require: false
  gem "letter_opener"
  gem "pivotal_git_scripts"
  gem "rack-mini-profiler", "~> 4.0"
  gem "rubocop", require: false
  gem "rubocop-capybara", require: false
  gem "rubocop-factory_bot", require: false
  gem "rubocop-performance", require: false
  gem "rubocop-rails", require: false
  gem "rubocop-rspec", require: false
  gem "rubocop-rspec_rails", require: false
  gem "spring", require: false
  gem "spring-commands-rspec", require: false
  gem "spring-watcher-listen", require: false
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "rails-controller-testing"
  gem "rspec-github", require: false
  gem "simplecov"
  gem "webmock"
end
