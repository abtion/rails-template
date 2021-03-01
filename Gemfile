# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.7.2"

gem "awesome_print"
gem "bootsnap", ">= 1.4.4", require: false
gem "cancancan"
gem "devise"
gem "devise-i18n"
gem "fast_jsonapi"
gem "jquery-rails"
gem "pg", "~> 1.0"
gem "pry"
gem "puma", "~> 5.2"
gem "rails", "~> 6.1.0"
gem "rollbar"
gem "sendgrid-actionmailer"
gem "sidekiq"
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem "webpacker", "~> 5.0"

group :development, :test do
  gem "abtion-scripts"
  gem "brakeman"
  gem "bundler-audit"
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "dotenv-rails"
  gem "erb_lint", require: false
  gem "i18n-tasks"
  gem "rspec-rails", "~> 4.0"
  gem "rubocop"
  gem "rubocop-performance"
  gem "rubocop-rails"
  gem "rubocop-rspec"
  gem "selenium-webdriver"
  gem "shoulda-matchers"
  gem "webdrivers", "~> 4.6", require: false
end

group :development do
  gem "listen", "~> 3.3"
  gem "pivotal_git_scripts"
  gem "rack-mini-profiler", "~> 2.0"
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "capybara-screenshot"
  gem "factory_bot_rails"
  gem "faker"
  gem "simplecov"
end
