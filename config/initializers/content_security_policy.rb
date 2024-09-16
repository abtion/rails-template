# frozen_string_literal: true

# Be sure to restart your server when you modify this file.

# Define an application-wide content security policy
# For further information see the following documentation
# https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Security-Policy

CONTENT_SECURITY_POLICY_MAP = {
  base_uri: [:none],
  form_action: [:self],
  frame_ancestors: [:none],
  connect_src: [:self],
  default_src: [:self],
  font_src: [:self],
  img_src: [:self],
  object_src: [:none],
  script_src: [:self],
  style_src: [:self]
}.freeze

Rails.application.configure do
  # Add Rollbar to the content security policy
  CONTENT_SECURITY_POLICY_MAP[:connect_src] << "https://api.rollbar.com"
  CONTENT_SECURITY_POLICY_MAP[:script_src] << "https://cdn.rollbar.com"

  # If you are using shakapacker-dev-server then specify shakapacker-dev-server host
  if Rails.env.development?
    CONTENT_SECURITY_POLICY_MAP[:connect_src].push("http://localhost:3035", "ws://localhost:3035")
  end

  config.content_security_policy do |policy|
    policy.base_uri(*CONTENT_SECURITY_POLICY_MAP[:base_uri])
    policy.form_action(*CONTENT_SECURITY_POLICY_MAP[:form_action])
    policy.frame_ancestors(*CONTENT_SECURITY_POLICY_MAP[:frame_ancestors])
    policy.default_src(*CONTENT_SECURITY_POLICY_MAP[:default_src])
    policy.font_src(*CONTENT_SECURITY_POLICY_MAP[:font_src])
    policy.img_src(*CONTENT_SECURITY_POLICY_MAP[:img_src])
    policy.object_src(*CONTENT_SECURITY_POLICY_MAP[:object_src])
    policy.script_src(*CONTENT_SECURITY_POLICY_MAP[:script_src])
    policy.style_src(*CONTENT_SECURITY_POLICY_MAP[:style_src])
    policy.connect_src(*CONTENT_SECURITY_POLICY_MAP[:connect_src])
    # Specify URI for violation reports
    # policy.report_uri "/csp-violation-report-endpoint"
  end

  # Generate session nonces for permitted importmap, inline scripts, and inline styles.
  config.content_security_policy_nonce_generator = lambda { |request|
    request.session[:nonce] ||= SecureRandom.hex
  }
  config.content_security_policy_nonce_directives = %w[script-src style-src]

  # Report violations without enforcing the policy.
  # config.content_security_policy_report_only = true
end
