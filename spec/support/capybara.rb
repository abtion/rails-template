# frozen_string_literal: true

require "capybara/rspec"
require "webdrivers/chromedriver" unless ENV.key?("DISABLE_WEBDRIVERS")

Capybara.register_driver(:headless_chrome) do |app|
  Capybara::Selenium::Driver.load_selenium
  browser_options = ::Selenium::WebDriver::Chrome::Options.new
  browser_options.args << "--headless"
  browser_options.args << "--disable-gpu"
  browser_options.args << "--window-size=1920,1080"
  Capybara::Selenium::Driver.new(app, browser: :chrome, options: browser_options)
end

Capybara.configure do |config|
  config.server_port = 9887 + ENV["TEST_ENV_NUMBER"].to_i
  config.default_max_wait_time = 5
  config.server = :puma, { Silent: true }
  config.default_driver = ENV.fetch("CAPYBARA_DRIVER", "headless_chrome").to_sym
  config.javascript_driver = ENV.fetch("CAPYBARA_DRIVER", "headless_chrome").to_sym
end
