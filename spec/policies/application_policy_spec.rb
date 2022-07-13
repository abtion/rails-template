# frozen_string_literal: true

require "rails_helper"
require "pundit/rspec"

RSpec.describe ApplicationPolicy, type: :policy do
  context "when user is admin" do
    permissions :index?, :new?, :create?, :edit?, :update?, :destroy?, :show? do
      it "grants access" do
        user = build(:user, :admin)
        expect(ApplicationPolicy).to permit(user)
      end
    end
  end

  context "when user is not admin" do
    permissions :index?, :new?, :create?, :edit?, :update?, :destroy?, :show? do
      it "denies access" do
        expect(ApplicationPolicy).to_not(permit(build(:user)))
      end
    end
  end

  context "when no user is provided" do
    it "raises an exception" do
      expect { ApplicationPolicy.new(nil, nil) }.to raise_error(Pundit::NotAuthorizedError)
      expect { Pundit.policy_scope(nil, :application) }.to raise_error(Pundit::NotAuthorizedError)
    end
  end

  describe "policy_scope" do
    context "when admin" do
      it "includes all records" do
        user = build(:user, :admin)

        users_in_db = create_list(:user, 5)

        expect(ApplicationPolicy::Scope.new(user, User).resolve).to match_array(users_in_db)
      end
    end

    context "when not admin" do
      it "includes no records" do
        user = build(:user)

        create_list(:user, 5)

        expect(ApplicationPolicy::Scope.new(user, User).resolve).to be_empty
      end
    end
  end
end
