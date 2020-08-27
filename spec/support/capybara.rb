# frozen_string_literal: true

require "capybara/rspec"
require "webdrivers/chromedriver"

chrome_bin = ENV.fetch("GOOGLE_CHROME_SHIM", nil)

Selenium::WebDriver::Chrome.path = chrome_bin if chrome_bin
chrome_opts = chrome_bin ? { "chromeOptions" => { "binary" => chrome_bin } } : {}

Capybara.configure do |config|
  config.server_port = 9887 + ENV["TEST_ENV_NUMBER"].to_i
end

Capybara.default_max_wait_time = 5
Capybara.server = :puma, { Silent: true }

Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    desired_capabilities: Selenium::WebDriver::Remote::Capabilities.chrome(chrome_opts)
  )
end

Capybara.register_driver :headless_chrome do |app|
  Capybara::Selenium::Driver.load_selenium
  browser_options = ::Selenium::WebDriver::Chrome::Options.new
  browser_options.args << "--headless"
  browser_options.args << "--disable-gpu"
  browser_options.args << "--window-size=1920,1080"
  Capybara::Selenium::Driver.new(app, browser: :chrome, options: browser_options)
end

Capybara.javascript_driver = ENV.fetch("CAPYBARA_DRIVER", "headless_chrome").to_sym
Capybara.default_driver = ENV.fetch("CAPYBARA_DRIVER", "headless_chrome").to_sym

# This will fail feature specs on javascript errors/warnings
RSpec.configure do |config|
  config.after(:each, type: :feature) do
    errors = page.driver.browser.manage.logs.get(:browser)

    if errors.present?
      aggregate_failures "javascript errors/warnings" do
        errors.each do |error|
          raise error.message
        end
      end
    end
  end
end
