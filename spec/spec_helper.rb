# frozen_string_literal: true

require "dotenv"
Dotenv.load(
  ".env.test.local",
  ".env.local",
  ".env.test",
  ".env"
)

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.order = :random

  Kernel.srand config.seed
end








# For easy killing rspec if it does not close down when aborting tests
# https://github.com/rspec/rspec-rails/issues/1353#issuecomment-93173691
puts "rspec pid: #{Process.pid}"

trap 'USR1' do
  threads = Thread.list

  puts
  puts "=" * 80
  puts "Received USR1 signal; printing all #{threads.count} thread backtraces."

  threads.each do |thr|
    description = thr == Thread.main ? "Main thread" : thr.inspect
    puts
    puts "#{description} backtrace: "
    puts thr.backtrace.join("\n")
  end

  puts "=" * 80
end
# $ kill -USR1 <the pid>
