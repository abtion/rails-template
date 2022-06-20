# frozen_string_literal: true

module Admin
  class BaseController < ApplicationController
    after_action :verify_authorized, except: :index
    after_action :verify_policy_scoped, only: :index

    def index; end
  end
end
