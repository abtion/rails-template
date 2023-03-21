# frozen_string_literal: true

require "rails_helper"

RSpec.describe ApplicationJob do
  it "can be used as basis for jobs" do
    rocket_class = double("Rocket")
    allow(rocket_class).to receive(:launch_all!)
    stub_const("Rocket", rocket_class)

    test_job = Class.new(ApplicationJob) do
      def perform
        Rocket.launch_all!(thrusters: true)
      end
    end

    expect { test_job.perform_now }.to_not raise_error
    expect(Rocket).to have_received(:launch_all!).with(thrusters: true)
  end
end
