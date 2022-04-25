# frozen_string_literal: true

Rack::Attack.throttle("requests by ip", limit: 20, period: 2, &:ip)
Rack::Attack.blocklist_ip(ENV.fetch("BLOCKED_IPS")) if ENV.fetch("BLOCKED_IPS", nil).present?
Rack::Attack.enabled = Rails.env.production? || ENV.key?("ENABLE_RACK_ATTACK")
