# frozen_string_literal: true

require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_mailbox/engine"
require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
# require "rails/test_unit/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module PROJECT_NAME
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Record the DB schema in SQL format for accuracy
    config.active_record.schema_format = :sql
    config.assets.paths << Rails.root.join("app", "assets", "fonts")
    config.assets.precompile << /\.(?:svg|eot|otf|woff|ttf)$/

    config.generators do |g|
      # Use UUID primary keys by default
      g.orm :active_record, primary_key_type: :uuid

      # Set RSpec as the test framework, with FactoryBot covering fixtures/factories
      g.test_framework :rspec
      g.fixture_replacement :factory_bot, dir: "spec/factories"

      # Don't generate system test files.
      g.system_tests = nil
    end

    # Configure Pry as the default rails console
    console do
      # this block is called only when running console,
      # so we can safely require pry here
      require "pry"
      config.console = Pry
    end
  end
end
