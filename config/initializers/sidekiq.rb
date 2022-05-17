# frozen_string_literal: true

if Rails.env.production?
  def sidekiq_username
    Constants::SIDEKIQ_USERNAME
  end

  def sidekiq_password
    Constants::SIDEKIQ_PASSWORD
  end

  require "sidekiq/web"

  Sidekiq::Web.use(Rack::Auth::Basic) do |username, password|
    ActiveSupport::SecurityUtils.secure_compare(username, sidekiq_username) &
      ActiveSupport::SecurityUtils.secure_compare(password, sidekiq_password)
  end
end

Sidekiq.configure_server do |config|
  config.redis = { url: Constants::REDIS_URL }
end

Sidekiq.configure_client do |config|
  config.redis = { url: Constants::REDIS_URL }
end
