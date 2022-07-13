# frozen_string_literal: true

module PunditViewHelper
  def enable_pundit(view, user)
    without_partial_double_verification do
      allow(view).to receive(:policy) do |record|
        Pundit.policy(user, record)
      end
    end
  end
end
