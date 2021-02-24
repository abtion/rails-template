# frozen_string_literal: true

unless Rails.env.production?
  require "rubocop/rake_task"
  require "bundler/audit/task"

  task rubocop: :environment do
    RuboCop::RakeTask.new(:rubocop) do |t|
      t.options = ["--display-cop-names"]
    end
  end

  task erblint: :environment do
    sh "bundle exec erblint --lint-all"
  end

  task brakeman: :environment do
    sh "bundle exec brakeman --quiet --no-summary"
  end

  task bundle_audit: :environment do
    sh "bundle exec bundle-audit --update --ignore CVE-2015-9284"
  end

  # Configure our own default.
  Rake::Task["default"].clear

  task(default: [:test])

  # Alias test
  task(test: [:spec])

  # Run the tests in most recently modified order and fail fast
  task test_failfast: :environment do
    sh 'bin/rspec --order defined --fail-fast $(find spec -iname "*_spec.rb" -exec ls -1t "{}" +;)'
  end

  # Run the tests and fail if coverage is below 100%
  task test_strict: :environment do
    ENV["CODE_COVERAGE_PERCENTAGE"] = "100"
    Rake::Task[:spec].invoke
  end

  # Run EVERYTHING
  task test_all_strict: :environment do
    ENV["CODE_COVERAGE_PERCENTAGE"] = "100"
    Rake::Task[:rubocop].invoke
    Rake::Task[:erblint].invoke
    Rake::Task[:brakeman].invoke
    Rake::Task[:bundle_audit].invoke
    Rake::Task["webpacker:compile"].invoke
    Rake::Task[:spec].invoke
  end
end
