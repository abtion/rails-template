# frozen_string_literal: true

require "rails_helper"

RSpec.describe Rack::Attack, type: :request do
  include ActiveSupport::Testing::TimeHelpers

  def requests_to_force_limit(limit)
    # In Rack::Attack, requests are tracked using cache keys that reset after a specific period,
    # similar to a bucket being emptied. For example, if a bucket (cache key) can hold up to 300
    # requests (balls) and is emptied every 5 minutes, starting at a random time means we might
    # not hit the limit by just exceeding it slightly. By sending double the limit plus one,
    # (601 requests in this case), we ensure at least one bucket overflows,
    # effectively testing the throttle. This method accounts for the uncertainty of when the bucket
    # resets, guaranteeing we trigger the rate limit at least once within any given period.
    (limit * 2) + 1
  end

  before do
    memory_store = ActiveSupport::Cache.lookup_store(:memory_store)
    allow(Rails).to receive(:cache).and_return(memory_store)
    allow(Rack::Attack).to receive(:enabled).and_return(true)
    Rack::Attack.reset!
  end

  describe "IP address throttling" do
    let(:limit) { 300 }

    context "when the number of requests does not exceed the limit" do
      it "does not change the request status" do
        limit.times do
          get "/", env: { REMOTE_ADDR: "1.2.3.4" }
          expect(response).to_not have_http_status(:too_many_requests)
        end
      end
    end

    context "when the number of requests is higher than the limit" do
      it "changes the request status to 429" do
        statuses = []

        requests_to_force_limit(limit).times do |i|
          get "/", env: { REMOTE_ADDR: "1.2.3.5" }
          statuses[i] = response.status
        end

        expect(statuses).to include(429)
      end

      context "when the IP addresses are not the same" do
        it "doesn't throttle the requests" do
          statuses = []

          requests_to_force_limit(limit).times do |i|
            get "/", env: { REMOTE_ADDR: "1.2.3.#{i}" }
            statuses[i] = response.status
          end

          expect(statuses).to_not include(429)
        end
      end
    end
  end

  describe "throttle logins by IP address" do
    it "throttles excessive login attempts by IP address" do
      freeze_time do
        limit = 5
        email = "user@example.com"
        password = "incorrect"
        ip_address = "1.2.3.4"

        # Make the allowed number of login attempts
        limit.times do
          post "/users/sign_in",
               params: { user: { email: email, password: password } },
               env: { "REMOTE_ADDR" => ip_address }
          expect(response).to_not have_http_status(:too_many_requests)
        end

        # Make one more attempt which should be throttled
        post "/users/sign_in",
             params: { user: { email: email, password: password } },
             env: { "REMOTE_ADDR" => ip_address }
        expect(response).to have_http_status(:too_many_requests)
      end
    end
  end

  describe "throttle logins by email address" do
    it "throttles excessive login attempts by email address" do
      limit = 5
      email = "user@example.com"

      freeze_time do
        # Make the allowed number of login attempts with the same email
        limit.times do
          post "/users/sign_in", params: { user: { email: email, password: "incorrect" } }
          expect(response).to_not have_http_status(:too_many_requests)
        end

        # Make one more attempt which should be throttled
        post "/users/sign_in", params: { user: { email: email, password: "incorrect" } }
        expect(response).to have_http_status(:too_many_requests)
      end
    end
  end
end
