# frozen_string_literal: true

Rack::Attack.throttle("requests by ip", limit: 20, period: 2, &:ip)
Rack::Attack.blocklist_ip(ENV["BLOCKED_IPS"]) if ENV["BLOCKED_IPS"].present?
Rack::Attack.enabled = Rails.env.production? || ENV["ENABLE_RACK_ATTACK"].present?
