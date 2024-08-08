# frozen_string_literal: true

# Be sure to restart your server when you modify this file.

# Define an application-wide content security policy
# For further information see the following documentation
# https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Security-Policy

Rails.application.configure do
  config.content_security_policy do |policy|
    policy.base_uri        :none
    policy.default_src     :self
    policy.font_src        :self, :https, :data
    policy.img_src         :self, :https, :data
    policy.form_action     :self
    policy.frame_ancestors :none
    policy.object_src      :none
    policy.script_src      :self
    policy.style_src       :self
    # Specify URI for violation reports
    # policy.report_uri "/csp-violation-report-endpoint"

    # If you are using shakapacker-dev-server then specify shakapacker-dev-server host
    if Rails.env.development?
      policy.connect_src :self, :https, "http://localhost:3035", "ws://localhost:3035"
    end
  end

  # Generate session nonces for permitted importmap, inline scripts, and inline styles.
  config.content_security_policy_nonce_generator = ->(request) { request.session.id.to_s }
  config.content_security_policy_nonce_directives = %w(script-src style-src)

  # Report violations without enforcing the policy.
  # config.content_security_policy_report_only = true
end
