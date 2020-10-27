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

  it "renders the muffi image" do
    stub_devise_helpers

    render

    image_selector = "img[src*='muffi-background-image']"

    expect(rendered).to have_css(image_selector)
  end

  context "with danish locale" do
    before { I18n.locale = :da }

    after { I18n.locale = I18n.default_locale }

    it "displays danish text" do
      stub_devise_helpers

      render

      expect(rendered).to have_selector("h2", exact_text: "Log ind")
    end

    it "renders a login form" do
      stub_devise_helpers

      render

      email_selector = [
        "input",
        "[type=email]",
        "[name='user[email]']",
        "[placeholder='navn@domæne.dk']"
      ].join

      password_selector = [
        "input",
        "[type=password]",
        "[name='user[password]']",
        "[placeholder='Indtast kodeord']"
      ].join

      remember_me_selector = [
        "input",
        "[type=checkbox]",
        "[name='user[remember_me]']"
      ].join

      submit_selector = [
        "input",
        "[type=submit]",
        "[value='Log ind']"
      ].join

      expect(rendered).to have_css(email_selector)
      expect(rendered).to have_css(password_selector)
      expect(rendered).to have_css(remember_me_selector)
      expect(rendered).to have_css(submit_selector)
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

    it "renders a login form" do
      stub_devise_helpers

      render

      email_selector = [
        "input",
        "[type=email]",
        "[name='user[email]']",
        "[placeholder='name@address.com']"
      ].join

      password_selector = [
        "input",
        "[type=password]",
        "[name='user[password]']",
        "[placeholder='Enter password']"
      ].join

      remember_me_selector = [
        "input",
        "[type=checkbox]",
        "[name='user[remember_me]']"
      ].join

      submit_selector = [
        "input",
        "[type=submit]",
        "[value='Log in']"
      ].join

      expect(rendered).to have_css(email_selector)
      expect(rendered).to have_css(password_selector)
      expect(rendered).to have_css(remember_me_selector)
      expect(rendered).to have_css(submit_selector)
    end
  end
end
