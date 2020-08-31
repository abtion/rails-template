# frozen_string_literal: true

module ShouldaMatchers
  Shoulda::Matchers.configure do |config|
    config.integrate do |with|
      with.test_framework(:rspec)
      with.library(:rails)
    end
  end
end
