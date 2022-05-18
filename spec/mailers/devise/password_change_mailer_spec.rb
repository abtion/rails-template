# frozen_string_literal: true

require "rails_helper"

RSpec.describe "devise/password_change_mailer_spec.rb", type: :mailer do
  describe "#password_change" do
    it "password changed mailer with correct body" do
      user = build(:user)

      mail = Devise::Mailer.password_change(user)

      expect(mail.subject).to eq("Password Changed")
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["mail_from@example.com"])

      expect(mail.body.encoded).to match("Hello #{user.email}!")
      expect(mail.body.encoded).to match(
        "We&#39;re contacting you to notify you that your password has been changed."
      )
    end
  end
end
