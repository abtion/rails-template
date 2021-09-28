# frozen_string_literal: true

require "rails_helper"

RSpec.describe ReactHelper do
  describe "passed props" do
    it "renders the props in data" do
      html = react_component("Foo", { bar: "value" })
      expected_props = %w[data-react-component="Foo"
                          data-react-props="{&quot;bar&quot;:&quot;value&quot;}"]

      expected_props.each do |segment|
        expect(html).to include(segment)
      end
    end

    context "when passing snake cased props" do
      it "renders the props in data in camel case" do
        html = helper.react_component("Foo", { foo_bar: "value" })
        expected_props = %w[data-react-component="Foo"
                            data-react-props="{&quot;fooBar&quot;:&quot;value&quot;}"]

        expected_props.each do |segment|
          expect(html).to include(segment)
        end
      end
    end

    context "when passing nested arrays" do
      it "renders the props in data" do
        html = helper.react_component("Foo",
                                      { foo_bar: [{ user_name: "Jens" }, { user_name: "Jensen" }],
                                        bar_foo: 1 })

        expected_props = ['data-react-component="Foo"',
                          'data-react-props="{&quot;fooBar&quot;:' \
                          "[{&quot;userName&quot;:&quot;Jens&quot;}," \
                          '{&quot;userName&quot;:&quot;Jensen&quot;}],&quot;barFoo&quot;:1}"']

        expected_props.each do |segment|
          expect(html).to include(segment)
        end
      end
    end

    context "when passing props as a string" do
      it "assumes that the string has already been converted to json" do
        html = helper.react_component("Foo", '{"key":"value"}')

        expected_props = ['data-react-component="Foo"',
                          'data-react-props="{&quot;key&quot;:&quot;value&quot;}']

        expected_props.each do |segment|
          expect(html).to include(segment)
        end
      end
    end
  end

  describe "container tag" do
    it "defaults to 'div'" do
      html = helper.react_component("Foo", {})

      expect(html).to match(%r{^<div.+</div>})
    end

    it "allows specifying another tag" do
      html = helper.react_component("Foo", {}, :p)

      expect(html).to match(%r{^<p.+</p>})
    end
  end

  context "when passing ActionController::Parameters" do
    before do
      ActionController::Parameters.permit_all_parameters = true
    end

    it "renders the props in data" do
      params = ActionController::Parameters.new({ bar: "value" })

      html = react_component("Foo", params)

      expected_props = %w[data-react-component="Foo"
                          data-react-props="{&quot;bar&quot;:&quot;value&quot;}"]

      expected_props.each do |segment|
        expect(html).to include(segment)
      end
    end
  end
end
