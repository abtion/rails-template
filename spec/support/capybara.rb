# frozen_string_literal: true

require "capybara/rspec"
require "webdrivers/chromedriver" unless Constants::DISABLE_WEBDRIVERS

# Default driver registrations
# https://github.com/teamcapybara/capybara/blob/master/lib/capybara/registrations/drivers.rb

Capybara.configure do |config|
  config.server_port = 9887 + Constants::TEST_ENV_NUMBER.to_i
  config.default_max_wait_time = 5
end

# Rails doesn't respect the driver settings provided directly to capybara:
# https://github.com/rails/rails/issues/34379
#
# So we set it the rails way instead of the capybara way
RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by(:selenium, using: Constants::CAPYBARA_DRIVER.to_sym,
                         screen_size: [1920, 1080])
  end
end
