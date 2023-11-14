# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# In bundler 2.4.22 you can do `ruby file: ".tool-versions"`, but heroku uses an old bundler
/^ruby (?<version>\d+\.\d+\.\d+)$/ =~ File.read(File.join(__dir__, ".tool-versions"))
ruby version

gem "awesome_print"
gem "bootsnap", ">= 1.4.4", require: false
gem "devise"
gem "devise-i18n"
gem "devise-pwned_password"
gem "jquery-rails"
gem "jsonapi-serializer"
gem "pg", "~> 1.5"
gem "pry-rails"
gem "puma", "~> 6.4"
gem "pundit"
gem "rack-attack"
gem "rails", "~> 7.1.2"
gem "rails-i18n"
gem "rollbar"
gem "shakapacker", "7.1.0"
gem "sidekiq"
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]

group :development, :test do
  gem "brakeman"
  gem "bullet"
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "dotenv-rails"
  gem "erb_lint", require: false
  gem "factory_bot_rails"
  gem "faker"
  gem "i18n-tasks"
  gem "rspec-rails", "~> 6.0.3"
  gem "rubocop"
  gem "rubocop-performance"
  gem "rubocop-rails"
  gem "rubocop-rspec"
  gem "selenium-webdriver", ">= 4.11"
  gem "shoulda-matchers"
end

group :development do
  gem "letter_opener"
  gem "listen", "~> 3.8"
  gem "pivotal_git_scripts"
  gem "rack-mini-profiler", "~> 3.1"
  gem "spring", require: false
  gem "spring-commands-rspec", require: false
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "rails-controller-testing"
  gem "simplecov"
  gem "webmock"
end
