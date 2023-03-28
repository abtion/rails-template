# frozen_string_literal: true

# Require authentication for ActiveStorage
Rails.application.config.after_initialize do
  # If all uploaded files must be globally accessible, but direct uploads still authenticated,
  # then change `ActiveStorage::BaseController` to `ActiveStorage::DirectUploadsController`
  ActiveStorage::BaseController.class_eval do
    class UnauthorizedError < StandardError; end # rubocop:disable Lint/ConstantDefinitionInBlock

    before_action :authenticate_user!
    rescue_from UnauthorizedError, with: :unauthorized

    private

    def authenticate_user!
      raise UnauthorizedError unless user_signed_in?
    end

    def unauthorized
      render plain: "Unauthorized", status: :unauthorized
    end
  end
end
