# frozen_string_literal: true

require "rails_helper"

RSpec.describe ApiAuthenticable, type: :model do
  describe "before_create" do
    it "sets an authentication_token automatically" do
      user = build(:user, authentication_token: nil)
      user.save

      expect(user.authentication_token).to_not be_nil
      expect(user.authentication_token.length).to eq(ApiAuthenticable::AUTHENTICATION_TOKEN_LENGTH)
    end
  end
end
