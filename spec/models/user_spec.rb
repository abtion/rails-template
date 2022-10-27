# frozen_string_literal: true

require "rails_helper"

RSpec.describe User do
  describe "password" do
    context "with 8 character long password" do
      it "user is valid" do
        user = build(:user)
        expect(user).to be_valid
      end
    end

    context "without 8 character long password" do
      it "user is not valid" do
        stub_strong_password(password: "AWMG129")
        user = build(:user, password: "AWMG129")

        expect(user).to_not be_valid
        expect(user.errors[:password]).to eq(["is too short (minimum is 8 characters)"])
      end
    end

    context "with weak password" do
      it "user is not valid" do
        stub_weak_password(password: "password", breach_count: 3_861_493)
        user = build(:user, password: "password")

        expect(user).to_not(be_valid)
        expect(user.errors[:password]).to eq([
          "has previously appeared in data breaches 3861493 times and should never be used.
          Please choose something harder to guess.".squish
        ])
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
