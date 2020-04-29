# frozen_string_literal: true

module Constraints
  class ApiVersion
    attr_reader :version

    def initialize(version)
      @version = version
    end

    def matches?(request)
      return false unless request&.headers

      request.headers["X-Api-Version"].presence == version
    end
  end
end
