# frozen_string_literal: true

class ExampleService < BaseService
  class InvalidMessageError < StandardError; end

  attr_reader :message

  def initialize(message)
    super()
    @message = message
  end

  def execute
    raise InvalidMessageError if @message == "invalid"

    message.upcase
  end
end
