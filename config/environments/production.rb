# frozen_string_literal: true

require "active_support/core_ext/integer/time"

Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # Code is not reloaded between requests.
  config.enable_reloading = false

  # Eager load code on boot. This eager loads most of Rails and
  # your application in memory, allowing both threaded web servers
  # and those relying on copy on write to perform better.
  # Rake tasks automatically ignore this option for performance.
  config.eager_load = true

  # Full error reports are disabled and caching is turned on.
  config.consider_all_requests_local = false
  config.action_controller.perform_caching = true

  # Ensures that a master key has been made available in ENV["RAILS_MASTER_KEY"], config/master.key,
  # or an environment key such as config/credentials/production.key. This key is used to decrypt
  # credentials (and other encrypted files).
  # config.require_master_key = true

  # Disable serving static files from `public/`, relying on NGINX/Apache to do so instead.
  # config.public_file_server.enabled = false

  # Enable serving of images, stylesheets, and JavaScripts from an asset server.
  # config.asset_host = "http://assets.example.com"

  # Specifies the header that your server uses for sending files.
  # config.action_dispatch.x_sendfile_header = "X-Sendfile" # for Apache
  # config.action_dispatch.x_sendfile_header = "X-Accel-Redirect" # for NGINX

  # Store uploaded files on the local file system (see config/storage.yml for options).
  config.active_storage.service = :local

  # Mount Action Cable outside main process or domain.
  # config.action_cable.mount_path = nil
  # config.action_cable.url = "wss://example.com/cable"
  # config.action_cable.allowed_request_origins = [ "http://example.com", /http:\/\/example.*/ ]

  # Assume all access to the app is happening through a SSL-terminating reverse proxy.
  # Can be used together with config.force_ssl for Strict-Transport-Security and secure cookies.
  # config.assume_ssl = true

  # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
  config.force_ssl = true

  # Skip http-to-https redirect for the default health check endpoint.
  # config.ssl_options = { redirect: { exclude: ->(request) { request.path == "/up" } } }

  # Log to STDOUT by default
  config.logger = ActiveSupport::Logger.new($stdout)
                                       .tap  { |logger| logger.formatter = Logger::Formatter.new }
                                       .then { |logger| ActiveSupport::TaggedLogging.new(logger) }

  # Prepend all log lines with the following tags.
  config.log_tags = [:request_id]

  # "info" includes generic and useful information about system operation, but avoids logging too
  # much information to avoid inadvertent exposure of personally identifiable information (PII).
  # If you want to log everything, set the level to "debug".
  config.log_level = ENV.fetch("RAILS_LOG_LEVEL", "info")

  # Decrease unnecessary logging in production
  config.lograge.enabled = true

  # Use a different cache store in production.
  config.cache_store = :redis_cache_store, {
    url: ENV.fetch("REDIS_URL", "redis://localhost:6379"),
    expires_in: 1.week
  }

  # Use a real queuing backend for Active Job (and separate queues per environment).
  # config.active_job.queue_adapter = :resque
  # config.active_job.queue_name_prefix = "project_name_pascal_production"
  config.action_mailer.deliver_later_queue_name = "mailers"

  # Disable caching for Action Mailer templates even if Action Controller
  # caching is enabled.
  config.action_mailer.perform_caching = false

  config.action_mailer.delivery_method = :smtp
  if ENV.key?("SMTP_USERNAME")
    config.action_mailer.smtp_settings = {
      address: "smtp-relay.brevo.com",
      port: 587,
      user_name: ENV.fetch("SMTP_USERNAME"),
      password: ENV.fetch("SMTP_PASSWORD"),
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

  # Ignore bad email addresses and do not raise email delivery errors.
  # Set this to true and configure the email server for immediate delivery to raise delivery errors.
  # config.action_mailer.raise_delivery_errors = false

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation cannot be found).
  config.i18n.fallbacks = true

  # Don't log any deprecations.
  config.active_support.report_deprecations = false

  # Do not dump schema after migrations.
  config.active_record.dump_schema_after_migration = false

  # Enable DNS rebinding protection and other `Host` header attacks.
  # config.hosts = [
  #   "example.com",     # Allow requests from example.com
  #   /.*\.example\.com/ # Allow requests from subdomains like `www.example.com`
  # ]
  # Skip DNS rebinding protection for the default health check endpoint.
  # config.host_authorization = { exclude: ->(request) { request.path == "/up" } }
end
