# frozen_string_literal: true

module ApplicationHelper
  def field_error(field:, resource:)
    return unless resource.errors.key?(field)

    errors_array = resource.errors.messages[field]
    translated_attribute = resource.class.human_attribute_name(field)

    tag.div do
      errors_array.map do |error|
        concat(tag.p("#{translated_attribute} #{error}.", class: "text-danger-800 text-sm"))
      end
    end
  end
end
