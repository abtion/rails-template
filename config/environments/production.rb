# frozen_string_literal: true

require "active_support/core_ext/integer/time"
require "open-uri"
require "json"

Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # Code is not reloaded between requests.
  config.cache_classes = true

  # Eager load code on boot. This eager loads most of Rails and
  # your application in memory, allowing both threaded web servers
  # and those relying on copy on write to perform better.
  # Rake tasks automatically ignore this option for performance.
  config.eager_load = true

  # Full error reports are disabled and caching is turned on.
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # Ensures that a master key has been made available in either ENV["RAILS_MASTER_KEY"]
  # or in config/master.key. This key is used to decrypt credentials (and other encrypted files).
  # config.require_master_key = true

  # Disable serving static files from the `/public` folder by default since
  # Apache or NGINX already handles this.
  config.public_file_server.enabled = ENV["RAILS_SERVE_STATIC_FILES"].present?

  # Enable serving of images, stylesheets, and JavaScripts from an asset server.
  # config.asset_host = 'http://assets.example.com'

  # Specifies the header that your server uses for sending files.
  # config.action_dispatch.x_sendfile_header = 'X-Sendfile' # for Apache
  # config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect' # for NGINX

  # Store uploaded files on the local file system (see config/storage.yml for options).
  config.active_storage.service = :local

  # Mount Action Cable outside main process or domain.
  # config.action_cable.mount_path = nil
  # config.action_cable.url = 'wss://example.com/cable'
  # config.action_cable.allowed_request_origins = [ 'http://example.com', /http:\/\/example.*/ ]

  # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
  config.force_ssl = true

  # Use the lowest log level to ensure availability of diagnostic information
  # when problems arise.
  config.log_level = :info

  # Prepend all log lines with the following tags.
  config.log_tags = [:request_id]

  # Use a different cache store in production.
  # config.cache_store = :mem_cache_store

  # Use a real queuing backend for Active Job (and separate queues per environment).
  # config.active_job.queue_adapter     = :resque
  # config.active_job.queue_name_prefix = "project_name_snake_production"
  config.action_mailer.deliver_later_queue_name = "mailers"

  config.action_mailer.perform_caching = false
  config.action_mailer.delivery_method = :smtp

  if ENV.key?("brevo_USERNAME")
    config.action_mailer.smtp_settings = {
      address: "smtp-relay.brevo.com",
      port: 587,
      user_name: ENV.fetch("BREVO_USERNAME"),
      password: ENV.fetch("BREVO_PASSWORD"),
      authentication: "login",
      enable_starttls_auto: true
    }
  elsif ENV.key?("MAILTRAP_API_TOKEN")
    response = URI.parse("https://mailtrap.io/api/v1/inboxes.json?api_token=#{ENV.fetch('MAILTRAP_API_TOKEN')}").read
    first_inbox = JSON.parse(response)[0]

    # Port 25 is not available due to limitations in AWS ec2 which heroku is using under the hood.
    # https://devcenter.heroku.com/changelog-items/2198
    # https://help.heroku.com/IR3S6I5X/problem-in-sending-e-mails-through-smtp
    # https://aws.amazon.com/premiumsupport/knowledge-center/ec2-port-25-throttle/
    available_ports = first_inbox["smtp_ports"] - [25]

    config.action_mailer.smtp_settings = {
      address: first_inbox["domain"],
      port: available_ports[0],
      user_name: first_inbox["username"],
      password: first_inbox["password"],
      authentication: :plain,
      domain: first_inbox["domain"]
    }
  end

  hostname = ENV.fetch("DOMAIN_NAME", nil)
  hostname ||= "#{ENV.fetch('HEROKU_APP_NAME')}.herokuapp.com"
  config.action_mailer.default_url_options = { host: hostname }

  # Only require MAIL_FROM when we've set up a host name for the app
  default_from = ENV.key?("DOMAIN_NAME") ? ENV.fetch("MAIL_FROM") : "info@#{hostname}"
  config.action_mailer.default_options = { from: default_from }

  # Ignore bad email addresses and do not raise email delivery errors.
  # Set this to true and configure the email server for immediate delivery to raise delivery errors.
  # config.action_mailer.raise_delivery_errors = false

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation cannot be found).
  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners.
  config.active_support.deprecation = :notify

  # Log disallowed deprecations.
  config.active_support.disallowed_deprecation = :log

  # Tell Active Support which deprecation messages to disallow.
  config.active_support.disallowed_deprecation_warnings = []

  # Use default logging formatter so that PID and timestamp are not suppressed.
  config.log_formatter = Logger::Formatter.new

  # Use a different logger for distributed setups.
  # require "syslog/logger"
  # config.logger = ActiveSupport::TaggedLogging.new(Syslog::Logger.new 'app-name')

  if ENV["RAILS_LOG_TO_STDOUT"].present?
    logger           = ActiveSupport::Logger.new($stdout)
    logger.formatter = config.log_formatter
    config.logger    = ActiveSupport::TaggedLogging.new(logger)
  end

  # Do not dump schema after migrations.
  config.active_record.dump_schema_after_migration = false

  # Inserts middleware to perform automatic connection switching.
  # The `database_selector` hash is used to pass options to the DatabaseSelector
  # middleware. The `delay` is used to determine how long to wait after a write
  # to send a subsequent read to the primary.
  #
  # The `database_resolver` class is used by the middleware to determine which
  # database is appropriate to use based on the time delay.
  #
  # The `database_resolver_context` class is used by the middleware to set
  # timestamps for the last write to the primary. The resolver uses the context
  # class timestamps to determine how long to wait before reading from the
  # replica.
  #
  # By default Rails will store a last write timestamp in the session. The
  # DatabaseSelector middleware is designed as such you can define your own
  # strategy for connection switching and pass that into the middleware through
  # these configuration options.
  # config.active_record.database_selector = { delay: 2.seconds }
  # config.active_record.database_resolver = ActiveRecord::Middleware::DatabaseSelector::Resolver
  # config.active_record.database_resolver_context =
  #   ActiveRecord::Middleware::DatabaseSelector::Resolver::Session
end
