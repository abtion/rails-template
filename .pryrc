# frozen_string_literal: true

eval File.read(".irbrc") if File.exist?(".irbrc") # rubocop:disable Security/Eval

Pry.config.print = proc { |output, value|
  Pry::Helpers::BaseHelpers.stagger_output("=> #{value.ai}", output)
}
