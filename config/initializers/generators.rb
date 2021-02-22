# frozen_string_literal: true

Rails.application.config.generators do |g|
  # Use UUID primary keys by default
  g.orm(:active_record, primary_key_type: :uuid)

  # Set RSpec as the test framework, with FactoryBot covering fixtures/factories
  g.test_framework(:rspec)
  g.fixture_replacement(:factory_bot, dir: "spec/factories")

  # Don't generate system test files.
  g.system_tests = nil
end
