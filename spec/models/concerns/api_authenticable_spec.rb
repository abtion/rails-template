# frozen_string_literal: true

require "rails_helper"

RSpec.describe ApiAuthenticable, type: :model do
  describe "before_create" do
    it "sets an authentication_token automatically" do
      user = build(:user, authentication_token: nil)
      user.save

      expect(user.authentication_token).not_to(be_nil)
      expect(user.authentication_token.length).to eq(ApiAuthenticable::AUTHENTICATION_TOKEN_LENGTH)
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
