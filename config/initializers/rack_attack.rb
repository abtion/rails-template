# frozen_string_literal: true

if Rails.env.production? || ENV["ENABLE_RACK_ATTACK"].present?
  Rack::Attack.throttle("requests by ip", limit: 20, period: 2, &:ip)

  Rack::Attack.blocklist_ip(ENV["BLOCKED_IPS"]) if ENV["BLOCKED_IPS"].present?
end
