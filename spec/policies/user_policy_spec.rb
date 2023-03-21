# frozen_string_literal: true

require "rails_helper"
require "pundit/rspec"

RSpec.describe UserPolicy, type: :policy do
  context "when user is admin" do
    permissions :new?, :create?, :edit?, :update?, :destroy?, :show? do
      it "grants access" do
        user = build(:user, :admin)
        expect(UserPolicy).to permit(user)
      end
    end

    it "allows access to all of the scope" do
      user = build(:user, :admin)
      expect(Pundit.policy_scope(user, User)).to eq(User.all)
    end
  end

  context "when user is not admin" do
    permissions :new?, :create?, :edit?, :update?, :destroy?, :show? do
      it "denies access" do
        expect(UserPolicy).to_not(permit(build(:user)))
      end
    end

    it "does not allow access to any of the scope" do
      user = build(:user)
      expect(Pundit.policy_scope(user, User)).to eq(User.none)
    end
  end

  context "when no user is provided" do
    it "raises an exception" do
      expect { UserPolicy.new(nil, nil) }.to raise_error(Pundit::NotAuthorizedError)
      expect { Pundit.policy_scope(nil, :application) }.to raise_error(Pundit::NotAuthorizedError)
    end
  end

  describe "#permitted_attributes" do
    it "returns the correct attributes" do
      expect(UserPolicy.new(build(:user),
                            nil).permitted_attributes).to contain_exactly(:email, :name, :password,
                                                                          :password_confirmation)
    end
  end
end
