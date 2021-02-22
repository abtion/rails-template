# frozen_string_literal: true

Rails.application.config.console do
  # this block is called only when running console,
  # so we can safely require pry here
  require "pry"
  config.console = Pry
end
