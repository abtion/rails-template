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
gem "pg", "~> 1.5"
gem "pry-rails"
gem "puma", "~> 6.4"
gem "pundit"
gem "rack-attack"
gem "rails", "~> 7.1.3"
gem "rails-i18n"
gem "rollbar"
gem "shakapacker", "8.0.2"
gem "sidekiq"
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]

group :development, :test do
  gem "bullet"
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "dotenv-rails"
  gem "erb_lint", require: false
  gem "factory_bot_rails"
  gem "faker"
  gem "i18n-tasks"
  gem "rspec-rails", "~> 7.0.1"
  gem "selenium-webdriver", ">= 4.11"
  gem "shoulda-matchers"
end

group :development do
  gem "brakeman", require: false
  gem "letter_opener"
  gem "listen", "~> 3.9"
  gem "pivotal_git_scripts"
  gem "rack-mini-profiler", "~> 3.3"
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
  gem "simplecov"
  gem "webmock"
end
