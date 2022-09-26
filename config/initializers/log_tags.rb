# frozen_string_literal: true

Rails.application.config.log_tags = [
  lambda { |req|
    session_key = Rails.application.config.session_options[:key]
    session_data = req.cookie_jar.encrypted[session_key]

    user_id = session_data&.dig("warden.user.user.key", 0, 0)

    if user_id
      "user: #{user_id}"
    else
      "no user"
    end
  }
]
