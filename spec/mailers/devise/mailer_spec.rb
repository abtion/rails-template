# frozen_string_literal: true

require "rails_helper"

RSpec.describe Devise::Mailer do
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

  describe "#reset_password_instructions" do
    it "reset password mailer with correct body" do
      user = build(:user)

      mail = Devise::Mailer.reset_password_instructions(user, "fake-token")

      expect(mail.subject).to eq("Reset password instructions")
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["mail_from@example.com"])

      expect(mail.body.encoded).to match("Hello #{user.email}!")
      expect(mail.body.encoded).to match(
        "Someone has requested a link to change your
        password. You can do this through the link below.".squish
      )
      expect(mail.body.encoded).to have_link(
        "Change my password",
        href: edit_user_password_url(user, reset_password_token: "fake-token")
      )
      expect(mail.body.encoded).to match(
        "If you didn&#39;t request this, please ignore this email."
      )
      expect(mail.body.encoded).to match(
        "Your password won&#39;t change until you access the link above and create a new one."
      )
    end
  end
end
