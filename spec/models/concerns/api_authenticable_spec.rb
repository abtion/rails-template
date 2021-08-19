# frozen_string_literal: true

require "rails_helper"

RSpec.describe ApiAuthenticable, type: :model do
  describe "before_create" do
    context "when class can be found by token" do
      it "sets an authentication_token automatically" do
        user = build(:user, authentication_token: nil)
        user.save

        expect(user.authentication_token).to_not be_nil
        expect(user.authentication_token.length).to eq(
          ApiAuthenticable::AUTHENTICATION_TOKEN_LENGTH
        )
      end
    end

    context "when class already has token" do
      it "does not alter theauthentication_token" do
        old_token = Devise.friendly_token(ApiAuthenticable::AUTHENTICATION_TOKEN_LENGTH)
        new_token = Devise.friendly_token(ApiAuthenticable::AUTHENTICATION_TOKEN_LENGTH)
        user = build(:user, authentication_token: old_token)

        allow(Devise).to receive(:friendly_token).and_return(old_token, new_token)
        allow(User).to receive(:find_by).and_return(true, false)

        user.save

        expect(user.authentication_token).to eq(new_token)
        expect(User).to have_received(:find_by).twice
        expect(Devise).to have_received(:friendly_token).twice
      end
    end
  end

  describe "valid_token?" do
    it "Securely compares the tokens (prefixed with 'Token ')" do
      user = build(:user, authentication_token: "SecurelyRandomToken")

      allow(ActiveSupport::SecurityUtils).to receive(:secure_compare)
        .and_return(:secure_compare_boolean_result)

      expect(user.valid_token?("Token SecurelyRandomToken")).to eq(:secure_compare_boolean_result)
      expect(ActiveSupport::SecurityUtils).to have_received(:secure_compare)
        .with("Token SecurelyRandomToken", "Token SecurelyRandomToken")
    end

    it "behaves nicely if no token is provided" do
      user = build(:user, authentication_token: nil)

      expect(user.valid_token?(nil)).to eq(false)
    end
  end
end
