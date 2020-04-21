# frozen_string_literal: true

require "simplecov"

unless ENV["DISABLE_SIMPLECOV"] == "true"
  SimpleCov.start("rails") do
    add_filter "spec"
  end
end
