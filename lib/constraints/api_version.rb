# frozen_string_literal: true

module Constraints
  class ApiVersion
    attr_reader :version

    def initialize(version)
      @version = version
    end

    def matches?(request)
      request.headers["X-Api-Version"].present? &&
        request.headers["X-Api-Version"] == version
    end
  end
end
