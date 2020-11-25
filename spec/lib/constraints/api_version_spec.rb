# frozen_string_literal: true

require "rails_helper"

RSpec.describe Constraints::ApiVersion do
  describe "#matches?" do
    context "when 'X-Api-Version' header matches version attribute" do
      it "returns true " do
        version = "1.33.7"
        version_constraints = Constraints::ApiVersion.new(version)
        mock_request = double("Request", headers: { "X-Api-Version" => version })

        expect(version_constraints.matches?(mock_request)).to eq(true)
      end
    end

    context "when 'X-Api-Version' header doesn't match version attribute" do
      it "returns false" do
        version = "1.33.7"
        version_constraints = Constraints::ApiVersion.new(version)
        mock_request = double("Request", headers: { "X-Api-Version" => "7.33.1" })

        expect(version_constraints.matches?(mock_request)).to eq(false)
      end
    end

    context "when no 'X-Api-Version' header present" do
      it "returns false" do
        version = "1.33.7"
        version_constraints = Constraints::ApiVersion.new(version)
        mock_request = double("Request", headers: {})

        expect(version_constraints.matches?(mock_request)).to eq(false)
      end
    end

    context "when no headers present" do
      it "returns false" do
        version = "1.33.7"
        version_constraints = Constraints::ApiVersion.new(version)

        expect(version_constraints.matches?(nil)).to eq(false)
      end
    end
  end
end
