# frozen_string_literal: true

require "rails_helper"

RSpec.describe ExampleService, type: :service do
  describe "#execute" do
    it "transforms the message to uppercase" do
      service = ExampleService.new("Hello, world!")
      result = service.execute

      expect(result).to eq("HELLO, WORLD!")
    end

    context "when message is 'invalid'" do
      it "raises with InvalidMessageError" do
        service = ExampleService.new("invalid")

        expect do
          service.execute
        end.to raise_error(ExampleService::InvalidMessageError)
      end
    end
  end
end
