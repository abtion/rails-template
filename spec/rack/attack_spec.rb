# frozen_string_literal: true

require "rails_helper"

RSpec.describe Rack::Attack, type: :request do
  include ActiveSupport::Testing::TimeHelpers

  before do
    # Use memory cache store for this test
    memory_store = ActiveSupport::Cache.lookup_store(:memory_store)
    allow(Rails).to receive(:cache).and_return(memory_store)
    allow(Rack::Attack).to receive(:enabled).and_return(true)
    Rack::Attack.reset!
  end

  describe "IP address throttling" do
    let(:limit) { 20 }

    context "when the number of requests does not exceed the limit" do
      it "does not change the request status" do
        freeze_time do
          limit.times do
            get "/", env: { REMOTE_ADDR: "1.2.3.4" }
            expect(response).to_not(have_http_status(:too_many_requests))
          end
        end
      end
    end

    context "when the number of requests is higher than the limit" do
      it "changes the request status to 429" do
        freeze_time do
          statuses = []

          (limit + 1).times do |i|
            get "/", env: { REMOTE_ADDR: "1.2.3.5" }
            statuses[i] = response.status
          end

          expect(statuses).to include(429)
        end
      end

      context "when the IP-adresses are not the same" do
        it "doesn't throttle the requests" do
          freeze_time do
            statuses = []

            (limit + 1).times do |i|
              get "/", env: { REMOTE_ADDR: "1.2.3.#{i}" },
                       headers: { "action_dispatch.show_exceptions": "1" }
              statuses[i] = response.status
            end

            expect(statuses).to_not(include(429))
          end
        end
      end
    end
  end
end
