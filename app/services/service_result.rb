# frozen_string_literal: true

class ServiceResult
  attr_reader :payload, :errors

  def initialize(payload: nil, errors: [])
    @payload = payload
    @errors = errors
  end

  def successful?
    errors.empty?
  end
end
