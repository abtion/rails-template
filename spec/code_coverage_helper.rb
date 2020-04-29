# frozen_string_literal: true

require "simplecov"

unless ENV["DISABLE_SIMPLECOV"] == "true"
  SimpleCov.start("rails") do
    add_filter "spec"
    add_filter "vendor"
    minimum_coverage((ENV["CODE_COVERAGE_PERCENTAGE"] || 0).to_i)
  end
end
