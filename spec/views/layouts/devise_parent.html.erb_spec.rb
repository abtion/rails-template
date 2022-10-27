# frozen_string_literal: true

require "rails_helper"

RSpec.describe "layouts/devise" do
  it "renders the placeholder image" do
    render

    placeholder_image_div = ".PlaceholderImage"

    expect(rendered).to have_css(placeholder_image_div)
  end

  it "renders the muffi logo" do
    render

    logo_selector = "img[src*='.svg']"

    expect(rendered).to have_css(logo_selector)
  end
end
