# frozen_string_literal: true

require "active_support/core_ext/integer/time"

Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # Code is not reloaded between requests.
  config.enable_reloading = false

  # Eager load code on boot for better performance and memory savings (ignored by Rake tasks).
  config.eager_load = true

  # Full error reports are disabled.
  config.consider_all_requests_local = false

  # Turn on fragment caching in view templates.
  config.action_controller.perform_caching = true

  # Cache assets for far-future expiry since they are all digest stamped.
  config.public_file_server.headers = { "cache-control" => "public, max-age=#{1.year.to_i}" }

  # Enable serving of images, stylesheets, and JavaScripts from an asset server.
  # config.asset_host = "http://assets.example.com"

  # Store uploaded files on the local file system (see config/storage.yml for options).
  config.active_storage.service = :local

  # Assume all access to the app is happening through a SSL-terminating reverse proxy.
  config.assume_ssl = true

  # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
  config.force_ssl = true

  # Skip http-to-https redirect for the default health check endpoint.
  # config.ssl_options = { redirect: { exclude: ->(request) { request.path == "/up" } } }

  # Log to STDOUT with the current request id as a default log tag.
  config.log_tags = [:request_id]
  config.logger   = ActiveSupport::TaggedLogging.logger($stdout)

  # Change to "debug" to log everything (including potentially personally-identifiable
  # information!).
  config.log_level = ENV.fetch("RAILS_LOG_LEVEL", "info")

  # Decrease unnecessary logging in production
  config.lograge.enabled = true

  # Prevent health checks from clogging up the logs.
  config.silence_healthcheck_path = "/up"

  # Don't log any deprecations.
  config.active_support.report_deprecations = false

  # Replace the default in-process memory cache store with a durable alternative.
  # config.cache_store = :mem_cache_store

  # Replace the default in-process and non-durable queuing backend for Active Job.
  config.active_job.queue_adapter = :sidekiq
  config.action_mailer.deliver_later_queue_name = "mailers"

  # Ignore bad email addresses and do not raise email delivery errors.
  # Set this to true and configure the email server for immediate delivery to raise delivery errors.
  # config.action_mailer.raise_delivery_errors = false

  # Set host to be used by links generated in mailer templates.
  hostname = ENV.fetch("DOMAIN_NAME", nil)
  hostname ||= "#{ENV.fetch('HEROKU_APP_NAME')}.herokuapp.com"
  config.action_mailer.default_url_options = { host: hostname }

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

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation cannot be found).
  config.i18n.fallbacks = true

  # Do not dump schema after migrations.
  config.active_record.dump_schema_after_migration = false

  # Only use :id for inspections in production.
  config.active_record.attributes_for_inspect = [:id]

  # Enable DNS rebinding protection and other `Host` header attacks.
  # config.hosts = [
  #   "example.com",     # Allow requests from example.com
  #   /.*\.example\.com/ # Allow requests from subdomains like `www.example.com`
  # ]
  #
  # Skip DNS rebinding protection for the default health check endpoint.
  # config.host_authorization = { exclude: ->(request) { request.path == "/up" } }
end
