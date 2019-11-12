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

Capybara.javascript_driver = :chrome
Capybara.default_driver = :chrome

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
