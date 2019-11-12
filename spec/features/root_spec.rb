require "rails_helper"

RSpec.describe "Log in as a user", type: :feature do
  context "when a user logs in" do
    it "redirects to the root path" do
      user = create(:user, password: "passw0rd")

      visit "/users/sign_in"

      fill_in "Email", with: user.email
      fill_in "Password", with: "passw0rd"

      click_button "Log in"

      expect(page).to have_current_path("/")
    end
  end
end
