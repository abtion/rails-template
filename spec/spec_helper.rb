# frozen_string_literal: true

require "webmock/rspec"
require "dotenv"
Dotenv.load(
  ".env.test.local",
  ".env.local",
  ".env.test",
  ".env"
)

require "code_coverage_helper"

RSpec.configure do |config|
  WebMock.disable_net_connect!(
    allow: "https://chromedriver.storage.googleapis.com",
    allow_localhost: true
  )

  config.expect_with(:rspec) do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with(:rspec) do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.order = :random
  config.example_status_persistence_file_path = "tmp/spec_example_status_persistence.txt"
  config.profile_examples = 5

  Kernel.srand(config.seed)
end
