# frozen_string_literal: true

#
# This will fail feature specs on javascript errors/warnings
RSpec.configure do |config|
  config.after(:each, type: :system) do
    errors = page.driver.browser.manage.logs.get(:browser)

    if errors.present?
      aggregate_failures "javascript errors/warnings" do
        errors.each do |error|
          expect(error.level).to_not eq("SEVERE"), error.message
          expect(error.level).to_not eq("WARNING"), error.message
        end
      end
    end
  end
end
