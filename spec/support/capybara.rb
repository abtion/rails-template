# frozen_string_literal: true

require "capybara/rspec"
require "webdrivers/chromedriver" unless ENV.key?("DISABLE_WEBDRIVERS")

# Default driver registrations
# https://github.com/teamcapybara/capybara/blob/master/lib/capybara/registrations/drivers.rb

Capybara.configure do |config|
  config.server_port = 9887 + ENV["TEST_ENV_NUMBER"].to_i
  config.default_max_wait_time = 5
  config.server = :puma, { Silent: true }
  config.default_driver = ENV.fetch("CAPYBARA_DRIVER", "selenium_chrome_headless").to_sym
  config.javascript_driver = ENV.fetch("CAPYBARA_DRIVER", "selenium_chrome_headless").to_sym
end
