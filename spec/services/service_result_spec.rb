# frozen_string_literal: true

require "rails_helper"

describe ServiceResult do
  describe "#successful?" do
    context "with no errors" do
      it "returns true" do
        result = ServiceResult.new(errors: [])
        expect(result).to be_successful
      end
    end

    context "with errors" do
      it "returns false" do
        result = ServiceResult.new(errors: ["Wow!"])
        expect(result).to_not be_successful
      end
    end
  end
end
