# frozen_string_literal: true

require "rails_helper"

RSpec.describe User, type: :model do
  describe "admin role" do
    let(:user) { create(:user) }

    it "defaults to false" do
      expect(user.admin?).to be_falsy
    end

    it "can be set" do
      user.update(admin: true)
      expect(user.admin?).to be_truthy
    end
  end
end
