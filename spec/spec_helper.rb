require "dotenv"
Dotenv.load(
  ".env.test.local",
  ".env.local",
  ".env.test",
  ".env"
)

require "factory_bot"
require "capybara/rspec"
require "webdrivers/chromedriver"

chrome_bin = ENV.fetch("GOOGLE_CHROME_SHIM", nil)

Selenium::WebDriver::Chrome.path = chrome_bin if chrome_bin
chrome_opts = chrome_bin ? { "chromeOptions" => { "binary" => chrome_bin } } : {}

Capybara.configure do |config|
  config.server_port = 9887 + ENV["TEST_ENV_NUMBER"].to_i
end

Capybara.default_max_wait_time = 5

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

Capybara.javascript_driver = ENV.fetch("TEST_DRIVER", "headless_chrome").to_sym
Capybara.default_driver = ENV.fetch("TEST_DRIVER", "headless_chrome").to_sym

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  # Include FactoryBot's methods in the suite for more concise usage
  config.include FactoryBot::Syntax::Methods

  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.order = :random

  Kernel.srand config.seed
end
