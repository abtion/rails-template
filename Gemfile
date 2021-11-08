# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.0.2"

gem "awesome_print"
gem "bootsnap", ">= 1.4.4", require: false
gem "devise"
gem "devise-i18n"
gem "jquery-rails"
gem "jsonapi-serializer"
gem "pg", "~> 1.0"
gem "pry-rails"
gem "puma", "~> 5.5"
gem "pundit"
gem "rack-attack"
gem "rails", "~> 6.1.4"
gem "rollbar"
gem "sendgrid-actionmailer"
gem "sidekiq"
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem "webpacker", "~> 6.0.0.rc"

group :development, :test do
  gem "abtion-scripts"
  gem "brakeman"
  gem "bullet"
  gem "bundler-audit"
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "dotenv-rails"
  gem "erb_lint", require: false
  gem "i18n-tasks"
  gem "rspec-rails", "~> 5.0"
  gem "rubocop"
  gem "rubocop-performance"
  gem "rubocop-rails"
  gem "rubocop-rspec"
  gem "selenium-webdriver"
  gem "shoulda-matchers"
  gem "webdrivers", "~> 5.0", require: false
end

group :development do
  gem "listen", "~> 3.7"
  gem "pivotal_git_scripts"
  gem "rack-mini-profiler", "~> 2.3"
  gem "spring", require: false
  gem "spring-commands-rspec", require: false
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "capybara-screenshot"
  gem "factory_bot_rails"
  gem "faker"
  gem "simplecov"
end
