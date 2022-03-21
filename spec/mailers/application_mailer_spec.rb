# frozen_string_literal: true

require "rails_helper"

RSpec.describe ApplicationMailer do
  before do
    test_mailer = Class.new(ApplicationMailer) do
      def test_mail
        mail(to: "test@example.com", subject: "test") do |format| # rubocop:disable Rails/I18nLocaleTexts
          format.text do
            render plain: "Test Text"
          end
        end
      end
    end
    stub_const("TestMailer", test_mailer)
  end

  it "has a default from" do
    mail = TestMailer.test_mail

    expect(mail.from).to match_array("from@example.com")
  end
end
