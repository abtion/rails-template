# frozen_string_literal: true

module ReactHelper
  def react_component(name, props = {}, options = {}, &block)
    options = { tag: options } if options.is_a?(Symbol)

    props = camelize_props(props)

    html_options = options.reverse_merge(data: {})
    html_options[:data].tap do |data|
      data["react-component"] = name
      data["react-props"] = (props.is_a?(String) ? props : props.to_json)
    end

    html_tag = html_options[:tag] || :div

    # remove internally used properties so they aren't rendered to DOM
    html_options.except!(:tag)

    content_tag(html_tag, "", html_options, &block)
  end

  private

  def camelize_props(props) # rubocop:disable Metrics/MethodLength
    case props
    when Hash
      props.each_with_object({}) do |(key, value), new_props|
        new_key = key.to_s.camelize(:lower)
        new_value = camelize_props(value)
        new_props[new_key] = new_value
      end
    when Array
      props.map { |item| camelize_props(item) }
    else
      if defined?(ActionController::Parameters) && props.is_a?(ActionController::Parameters)
        camelize_props(props.to_h)
      else
        props
      end
    end
  end
end
