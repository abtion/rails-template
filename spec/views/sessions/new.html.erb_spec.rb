# frozen_string_literal: true

require "rails_helper"

RSpec.describe "devise/sessions/new", type: :view do
  def stub_devise_helpers
    without_partial_double_verification do
      allow(view).to receive(:resource) { User.new }
      allow(view).to receive(:resource_name).and_return(:user)
      allow(view).to receive(:devise_mapping) { Devise.mappings[:user] }
    end
  end

  context "with danish locale" do
    before { I18n.locale = :da }

    after { I18n.locale = I18n.default_locale }

    it "displays danish text" do
      stub_devise_helpers

      render

      expect(rendered).to have_selector("h2", exact_text: "Log ind")
    end
  end

  context "with english locale" do
    before { I18n.locale = :en }

    after { I18n.locale = I18n.default_locale }

    it "displays english text" do
      stub_devise_helpers

      render

      expect(rendered).to have_selector("h2", exact_text: "Log in")
    end
  end
end
