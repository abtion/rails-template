# frozen_string_literal: true

require "rails_helper"

RSpec.describe "rake example", type: :task do
  include_context "rake"

  it "outputs put message" do
    expect do
      subject.invoke
    end.to output("Test\n").to_stdout
  end
end
