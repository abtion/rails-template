# frozen_string_literal: true

require "rails_helper"

RSpec.describe ExampleService, type: :service do
  describe "#execute" do
    it "returns a ServiceResult" do
      service = ExampleService.new("Hello, world!")
      result = service.execute

      expect(result).to be_a(ServiceResult)
    end

    it "transforms the message to uppercase" do
      service = ExampleService.new("Hello, world!")
      result = service.execute

      expect(result.payload).to eq("HELLO, WORLD!")
    end
  end
end
