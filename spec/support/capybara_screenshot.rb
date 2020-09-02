# frozen_string_literal: true

require "capybara-screenshot/rspec"

Capybara::Screenshot.register_driver(:headless_chrome) do |driver, path|
  driver.browser.save_screenshot(path)
end
