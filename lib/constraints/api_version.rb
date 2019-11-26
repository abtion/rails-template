# frozen_string_literal: true

module Constraints
  class ApiVersion
    attr_reader :version, :default

    def initialize(version, use_default = false)
      @version = version
      @use_default = use_default
    end

    def matches?(request)
      if request.headers["X-Api-Version"].present?
        request.headers["X-Api-Version"] == @version
      else
        @use_default
      end
    end
  end
end
