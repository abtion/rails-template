# frozen_string_literal: true

class DeviseParentController < ApplicationController
  private

  def after_sign_in_path_for(resource)
    if resource.respond_to?(:pwned?) && resource.pwned?
      set_flash_message!(:warning, :warn_pwned, count: resource.pwned_count)
    end

    super
  end
end
