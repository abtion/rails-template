# frozen_string_literal: true

require "simplecov"

unless ENV.key?("DISABLE_SIMPLECOV")
  SimpleCov.start("rails") do
    add_filter "spec"
    add_filter "vendor"
    enable_coverage :branch
    primary_coverage :branch
    minimum_coverage(
      line: ENV.fetch("CODE_COVERAGE_PERCENTAGE", 0).to_i,
      branch: ENV.fetch("CODE_COVERAGE_PERCENTAGE", 0).to_i
    )
  end
end
