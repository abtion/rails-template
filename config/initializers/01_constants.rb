# frozen_string_literal: true

module Constants
  SEED_ADMIN_EMAIL = ENV.fetch("SEED_ADMIN_EMAIL", "admin@example.com")
  SEED_ADMIN_INITIAL_PASSWORD = ENV.fetch("SEED_ADMIN_INITIAL_PASSWORD", "F8osN3hiRjJ0dstGJUDR")
  MAIL_FROM = ENV.fetch("MAIL_FROM", "mail_from@example.com")
  SIDEKIQ_USERNAME = ENV.fetch("SIDEKIQ_USERNAME", "abtion")
  SIDEKIQ_PASSWORD = ENV.fetch("SIDEKIQ_PASSWORD", "43NoyAQsFpq9sY8fkois")
  HTTP_AUTH_USERNAME = ENV.fetch("HTTP_AUTH_USERNAME", nil)
  HTTP_AUTH_PASSWORD = ENV.fetch("HTTP_AUTH_PASSWORD", nil)
  LOCALE = ENV.fetch("LOCALE", "en")
  ROLLBAR_ACCESS_TOKEN = ENV.fetch("ROLLBAR_ACCESS_TOKEN", nil)
  ROLLBAR_ENV = ENV.fetch("ROLLBAR_ENV", nil)
  REDIS_URL = ENV.fetch("REDIS_URL", "redis://localhost:6379")
  DISABLE_WEBDRIVERS = ENV.fetch("DISABLE_WEBDRIVERS", nil)
  CAPYBARA_DRIVER = ENV.fetch("CAPYBARA_DRIVER", "headless_chrome")
  TEST_ENV_NUMBER = ENV.fetch("TEST_ENV_NUMBER", nil)
  ENABLE_RACK_ATTACK = ENV.fetch("ENABLE_RACK_ATTACK", nil)
  BLOCKED_IPS = ENV.fetch("BLOCKED_IPS", nil)
  BACKTRACE = ENV.fetch("BACKTRACE", nil)
end
