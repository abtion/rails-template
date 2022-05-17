# frozen_string_literal: true

Rack::Attack.throttle("requests by ip", limit: 20, period: 2, &:ip)
Rack::Attack.blocklist_ip(Constants::BLOCKED_IPS) if Constants::BLOCKED_IPS.present?
Rack::Attack.enabled = Rails.env.production? || Constants::ENABLE_RACK_ATTACK
