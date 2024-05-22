# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Root", type: :system do
  it "renders 'abtion-rails'" do
    visit root_path

    expect(page).to have_content("abtion-rails")
  end
end
