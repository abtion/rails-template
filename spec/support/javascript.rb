# frozen_string_literal: true

#
# This will fail feature specs on javascript errors/warnings
RSpec.configure do |config|
  config.after(:each, type: :system) do |example|
    errors = page.driver.browser.logs.get(:browser)

    disable_info = <<~TXT
      If the error is expected, handle the browser log in the test:

        it "logs a specific error" do
          logs = page.driver.browser.manage.logs.get(:browser)
          expect(logs.first.message).to include("A specific error")
        end

      Or ignore it with :ignore_js_errors:

        it "doesn't log in the user", :ignore_js_errors do
          fail_to_log_in
          expect(page).to have_text("Login failed")
        end
    TXT

    if errors.present? && !example.metadata[:ignore_js_errors]
      aggregate_failures "javascript errors/warnings" do
        errors.each do |error|
          message = ["Browser error:", error.message, disable_info].join("\n\n")

          expect(error.level).to_not eq("SEVERE"), message
          expect(error.level).to_not eq("WARNING"), message
        end
      end
    end
  end
end
