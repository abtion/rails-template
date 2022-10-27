# frozen_string_literal: true

require "rails_helper"

RSpec.describe Users::SessionsController do
  describe "#create" do
    context "with a pwned password" do
      it "allows sign in, but warns in a flash message" do
        request.env["devise.mapping"] = Devise.mappings[:user]
        user = create(:user, :admin, email: "some@domain.com", password: "woof-SAYS-muffi")
        stub_weak_password(password: "woof-SAYS-muffi", breach_count: 3_000)

        post :create, params: { user: { email: user.email, password: user.password } }

        expect(response).to redirect_to(root_path)
        expect(flash[:warning]).to eq(
          "Please note that the password you are using has been displayed
          in 3000 data breaches lately as a known used password -
          we suggest that you change your current password.".squish
        )
      end
    end
  end
end
