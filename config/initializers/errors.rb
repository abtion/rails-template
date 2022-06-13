# frozen_string_literal: true

ActionView::Base.field_error_proc = proc do |html_tag, _instance|
  if /<(input|textarea|select)/.match?(html_tag)
    html_field = Nokogiri::HTML::DocumentFragment.parse(html_tag)
    html_field.children.add_class("Input--error")
    ActiveSupport::SafeBuffer.new(html_field.to_s)
  else
    html_tag
  end
end
