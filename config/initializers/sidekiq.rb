# frozen_string_literal: true

if Rails.env.production?
  def sidekiq_username
    ENV.fetch("SIDEKIQ_USERNAME")
  end

  def sidekiq_password
    ENV.fetch("SIDEKIQ_PASSWORD")
  end

  require "sidekiq/web"

  Sidekiq::Web.use(Rack::Auth::Basic) do |username, password|
    ActiveSupport::SecurityUtils.secure_compare(username, sidekiq_username) &
      ActiveSupport::SecurityUtils.secure_compare(password, sidekiq_password)
  end
end

redis_config = {
  url: ENV.fetch("REDIS_URL"),
  ssl_params: { verify_mode: OpenSSL::SSL::VERIFY_NONE }
}

Sidekiq.configure_server do |config|
  config.redis = redis_config
end

Sidekiq.configure_client do |config|
  config.redis = redis_config
end
