# frozen_string_literal: true

require "rails_helper"

RSpec.describe ApplicationRecord do
  describe "uuid ordering" do
    it "implicitly orders by created_at" do
      expect(ApplicationRecord.implicit_order_column).to eq("created_at")
    end
  end
end
