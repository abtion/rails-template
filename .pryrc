# frozen_string_literal: true

eval File.read(".irbrc") if File.exist?(".irbrc") # rubocop:disable Security/Eval
require "awesome_print"

AwesomePrint.defaults = {
  indent: -2,
  sort_keys: true
}
Pry.config.print = proc { |output, value|
  Pry::Helpers::BaseHelpers.stagger_output("=> #{value.ai}", output)
}
