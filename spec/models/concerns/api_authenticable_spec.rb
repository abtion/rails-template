# frozen_string_literal: true

require "rails_helper"

RSpec.describe ApiAuthenticable do
  describe "before_create" do
    context "when authentication_token doesn't already exist" do
      it "sets an authentication_token automatically" do
        user = build(:user, authentication_token: nil)
        allow(Devise).to receive(:friendly_token).and_call_original

        user.save

        expect(user.authentication_token).to_not be_nil
        expect(user.authentication_token.length).to eq(
          ApiAuthenticable::AUTHENTICATION_TOKEN_LENGTH
        )
        expect(Devise).to have_received(:friendly_token).once
      end
    end

    context "when authentication_token already taken by other class" do
      it "generates a new token" do
        old_token = Devise.friendly_token(ApiAuthenticable::AUTHENTICATION_TOKEN_LENGTH)
        new_token = Devise.friendly_token(ApiAuthenticable::AUTHENTICATION_TOKEN_LENGTH)

        allow(Devise).to receive(:friendly_token).and_return(old_token, old_token, new_token)

        create(:user, authentication_token: old_token)
        user = create(:user, authentication_token: old_token)

        expect(user.authentication_token).to eq(new_token)
        expect(Devise).to have_received(:friendly_token).thrice
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

      expect(user.valid_token?(nil)).to be(false)
    end
  end
end
