# frozen_string_literal: true

require "rails_helper"

RSpec.describe "errors/not_found" do
  it "renders not_found template" do
    render

    expect(rendered).to have_content("404")
    expect(rendered).to have_content("The page you were looking for doesn't exist.")
    expect(rendered).to have_content(
      "You may have mistyped the address or the page may have moved."
    )
  end
end
