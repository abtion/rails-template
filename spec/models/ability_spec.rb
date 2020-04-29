# frozen_string_literal: true

require "rails_helper"
require "cancan/matchers"

RSpec.describe Ability, type: :model do
  context "when user is admin" do
    it "is able to manage all" do
      admin = build(:user, :admin)
      ability = Ability.new(admin)

      expect(ability).to be_able_to(:manage, :all)
    end
  end

  context "when user is user" do
    it "is not able to manage all" do
      admin = build(:user)
      ability = Ability.new(admin)

      expect(ability).to_not be_able_to(:manage, :all)
    end
  end
end
