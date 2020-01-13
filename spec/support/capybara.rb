# frozen_string_literal: true

require "capybara/rspec"
require "webdrivers/chromedriver"

Capybara.register_driver :chrome do |app|
  chrome_bin = ENV.fetch("GOOGLE_CHROME_SHIM", nil)
  chrome_opts = if chrome_bin
    Selenium::WebDriver::Chrome.path = chrome_bin
    { "chromeOptions" => { "binary" => chrome_bin } }
  else
    {}
  end

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

Capybara.register_driver :headless_firefox do |app|
  Capybara::Selenium::Driver.load_selenium
  browser_options = ::Selenium::WebDriver::Firefox::Options.new
  browser_options.args << "--headless"
  Capybara::Selenium::Driver.new(app, browser: :firefox, options: browser_options)
end

Capybara.javascript_driver = ENV.fetch("CAPYBARA_DRIVER", "headless_chrome").to_sym
Capybara.default_driver = ENV.fetch("CAPYBARA_DRIVER", "headless_chrome").to_sym

Capybara.default_max_wait_time = 5
Capybara.configure do |config|
  config.server_port = 9887 + ENV["TEST_ENV_NUMBER"].to_i
end
