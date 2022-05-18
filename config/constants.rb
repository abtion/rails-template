# frozen_string_literal: true

module Constants
  SEED_ADMIN_EMAIL = ENV.fetch("SEED_ADMIN_EMAIL", nil)
  SEED_ADMIN_INITIAL_PASSWORD = ENV.fetch("SEED_ADMIN_INITIAL_PASSWORD", nil)
  MAIL_FROM = ENV.fetch("MAIL_FROM", nil)
  SIDEKIQ_USERNAME = ENV.fetch("SIDEKIQ_USERNAME", nil)
  SIDEKIQ_PASSWORD = ENV.fetch("SIDEKIQ_PASSWORD", nil)
  HTTP_AUTH_USERNAME = ENV.fetch("HTTP_AUTH_USERNAME", nil)
  HTTP_AUTH_PASSWORD = ENV.fetch("HTTP_AUTH_PASSWORD", nil)
  LOCALE = ENV.fetch("LOCALE", "en")
  ROLLBAR_ACCESS_TOKEN = ENV.fetch("ROLLBAR_ACCESS_TOKEN", nil)
  ROLLBAR_ENV = ENV.fetch("ROLLBAR_ENV", nil)
  REDIS_URL = ENV.fetch("REDIS_URL", nil)
  DISABLE_WEBDRIVERS = ENV.fetch("DISABLE_WEBDRIVERS", nil)
  CAPYBARA_DRIVER = ENV.fetch("CAPYBARA_DRIVER", nil)
  TEST_ENV_NUMBER = ENV.fetch("TEST_ENV_NUMBER", nil)
  ENABLE_RACK_ATTACK = ENV.fetch("ENABLE_RACK_ATTACK", nil)
  BLOCKED_IPS = ENV.fetch("BLOCKED_IPS", nil)
  BACKTRACE = ENV.fetch("BACKTRACE", nil)
  RAILS_SERVE_STATIC_FILES = ENV.fetch("RAILS_SERVE_STATIC_FILES", nil)
  USE_LETTER_OPENER = ENV.fetch("USE_LETTER_OPENER", nil)
  ALLOWED_HOSTS = ENV.fetch("ALLOWED_HOSTS", nil)
  RAILS_LOG_TO_STDOUT = ENV.fetch("RAILS_LOG_TO_STDOUT", nil)
  SENDINBLUE_EMAIL = ENV.fetch("SENDINBLUE_EMAIL", nil)
  SENDINBLUE_PASSWORD = ENV.fetch("SENDINBLUE_PASSWORD", nil)
  DOMAIN_NAME = ENV.fetch("DOMAIN_NAME", nil)
  HEROKU_APP_NAME = "#{ENV.fetch('HEROKU_APP_NAME', nil)}.herokuapp.com".freeze
  DISABLE_SIMPLECOV = ENV.fetch("DISABLE_SIMPLECOV", nil)
  CODE_COVERAGE_PERCENTAGE = ENV.fetch("CODE_COVERAGE_PERCENTAGE", nil)
end
