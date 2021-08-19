# frozen_string_literal: true

require "rails_helper"

RSpec.describe Rack::Attack, type: :request do
  include ActiveSupport::Testing::TimeHelpers

  def requests_to_force_limit(limit)
    # Rack::Attack stores request counts under cache keys that are computed based on the period and
    # the request identifier (for instance the IP).
    #
    # The cache key changes every x seconds (x = the chosen period), but we don't know when.
    #
    # Figuratively speaking we have a bucket (cache key) to throw balls (requests) into.
    #
    # We know that:
    # - The bucket can only hold 20 balls
    # - The bucket will be emptied (the cache key changed) every 2 seconds
    # - We are able to throw many more than 20 balls in 2 seconds
    #
    # Since we start throwing balls at an random point in time, there's no way to know when the
    # bucket will be emptied next. So it is not certain that throwing 21 balls at the bucket will
    # make it overflow.
    #
    # If we however throw 41 balls, we are sure to make the bucket overflow.
    # Even if the bucket is after we've thrown our first 20 balls, that still leaves 21 more balls
    # to fill the bucket afterwards
    limit * 2 + 1
  end

  before do
    memory_store = ActiveSupport::Cache.lookup_store(:memory_store)
    allow(Rails).to receive(:cache).and_return(memory_store)
    allow(Rack::Attack).to receive(:enabled).and_return(true)
    Rack::Attack.reset!
  end

  describe "IP address throttling" do
    let(:limit) { 20 }

    context "when the number of requests is lower than the limit" do
      it "does not change the request status" do
        limit.times do
          get "/", env: { REMOTE_ADDR: "1.2.3.4" }
          expect(response.status).to_not eq(429)
        end
      end
    end

    context "when the number of requests is higher than the limit" do
      it "changes the request status to 429" do
        request_count = requests_to_force_limit(limit)

        request_count.times do |i|
          get "/", env: { REMOTE_ADDR: "1.2.3.5" }
          expect(response.status).to eq(429) if i == request_count - 1
        end
      end

      context "when the IP-adresses are not the same" do
        it "doesn't throttle the requests" do
          requests_to_force_limit(limit).times do |i|
            get "/", env: { REMOTE_ADDR: "1.2.3.#{i}" }
            expect(response.status).to_not eq(429)
          end
        end
      end
    end
  end
end
