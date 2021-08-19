# frozen_string_literal: true

require "rails_helper"

RSpec.describe User, type: :model do
  describe "password" do
    context "with 8 character long password" do
      it "user is valid" do
        user = build(:user, password: "12345678")
        expect(user).to be_valid
      end
    end

    context "without 8 character long password" do
      it "user is not valid" do
        user = build(:user, password: "1234567")
        expect(user).to_not be_valid
        expect(user.errors[:password]).to eq(["is too short (minimum is 8 characters)"])
      end
    end
  end

  describe "admin role" do
    let(:user) { create(:user) }

    it "defaults to false" do
      expect(user).to_not be_admin
    end

    it "can be set" do
      user.update(admin: true)
      expect(user).to be_admin
    end
  end
end
