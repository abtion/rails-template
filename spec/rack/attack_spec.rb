# frozen_string_literal: true

require "rails_helper"

RSpec.describe Rack::Attack, type: :request do
  include ActiveSupport::Testing::TimeHelpers

  before do
    memory_store = ActiveSupport::Cache.lookup_store(:memory_store)
    allow(Rails).to receive(:cache).and_return(memory_store)
    allow(Rack::Attack).to receive(:enabled).and_return(true)
    Rack::Attack.reset!
  end

  describe "IP address throttling" do
    let(:limit) { 300 }

    it "throttles requests from the same IP with status 429 when limit is exceeded" do
      freeze_time do
        # Get close to the limit without excersizing the whole stack for each request.
        # Otherwise the spec would be really too slow
        (limit - 1).times { Rack::Attack.cache.count("req/ip:1.2.3.5", 5.minutes) }

        # Reaching the limit
        get "/", env: { REMOTE_ADDR: "1.2.3.5" }
        expect(response).to_not have_http_status(:too_many_requests)

        # Exceeding the limit
        get "/", env: { REMOTE_ADDR: "1.2.3.5" }
        expect(response).to have_http_status(:too_many_requests)

        # Request from other IP
        get "/", env: { REMOTE_ADDR: "1.2.3.10" }
        expect(response).to_not have_http_status(:too_many_requests)
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
               params: { user: { email:, password: } },
               env: { "REMOTE_ADDR" => ip_address }
          expect(response).to_not have_http_status(:too_many_requests)
        end

        # Make one more attempt which should be throttled
        post "/users/sign_in",
             params: { user: { email:, password: } },
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
          post "/users/sign_in", params: { user: { email:, password: "incorrect" } }
          expect(response).to_not have_http_status(:too_many_requests)
        end

        # Make one more attempt which should be throttled
        post "/users/sign_in", params: { user: { email:, password: "incorrect" } }
        expect(response).to have_http_status(:too_many_requests)
      end
    end
  end
end
