# frozen_string_literal: true

module Admin
  class BaseController < ApplicationController
    before_action :validate_admin

    private

    def validate_admin
      authorize(current_user, :admin?)
    end
  end
end
