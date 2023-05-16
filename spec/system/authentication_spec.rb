# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Authentication" do
  describe "sign in" do
    it "redirects to the root path" do
      user = create(:user)

      visit "/users/sign_in"

      fill_in "Email", with: user.email
      fill_in "Password", with: user.password

      click_button "Sign in"

      expect(page).to have_current_path("/")
    end
  end

  describe "password reset" do
    it "allows resetting the password" do
      user = create(:user)

      visit "/users/sign_in"

      click_link "Forgot your password?"

      fill_in "Email", with: user.email

      expect do
        click_button("Send me reset password instructions")
      end.to change { ActionMailer::Base.deliveries.size }.by(1)

      sent_mail = ActionMailer::Base.deliveries.first

      expect(sent_mail.subject).to include("Reset password")
      reset_link = sent_mail.body.match(%r{(?<link>http.+password/edit[^"]+)})["link"]

      visit reset_link

      fill_in "user_password", with: "1234password!$"
      fill_in "user_password_confirmation", with: "1234password!$"

      stub_strong_password(password: "1234password!$")
      click_button "Change my password"

      expect(page).to have_content("Your password has been changed successfully")
    end
  end
end
