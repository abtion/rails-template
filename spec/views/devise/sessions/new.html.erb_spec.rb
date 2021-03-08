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

  it "renders the muffi logo" do
    stub_devise_helpers

    render

    logo_selector = "img[src*='muffi-logo']"

    expect(rendered).to have_css(logo_selector)
  end

  it "renders the placeholder image" do
    stub_devise_helpers

    render

    placeholder_image_div = ".placeholder-image"

    expect(rendered).to have_css(placeholder_image_div)
  end

  it "shows a remember me checkbox" do
    stub_devise_helpers

    render

    expect(rendered).to have_css("input[type=checkbox][name='user[remember_me]']")
  end

  context "with Danish locale" do
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

      submit_selector = [
        "input",
        "[type=submit]",
        "[value='Log ind']"
      ].join

      expect(rendered).to have_css(email_selector)
      expect(rendered).to have_css(password_selector)
      expect(rendered).to have_css(submit_selector)
    end

    it "shows a link to the forgotten password page" do
      stub_devise_helpers

      render

      expect(rendered).to have_css("a", exact_text: "Glemt dit kodeord?", normalize_ws: true)
    end

    it "shows a sign up text" do
      stub_devise_helpers

      render

      expect(rendered).to(
        have_css("small", exact_text: "Har du ikke en konto? Tilmeld dig her.", normalize_ws: true)
      )
      expect(rendered).to have_link("Tilmeld dig her", href: new_user_registration_path)
    end
  end

  context "with English locale" do
    before { I18n.locale = :en }

    after { I18n.locale = I18n.default_locale }

    it "displays English text" do
      stub_devise_helpers

      render

      expect(rendered).to have_selector("h2", exact_text: "Sign in")
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

      submit_selector = [
        "input",
        "[type=submit]",
        "[value='Sign in']"
      ].join

      expect(rendered).to have_css(email_selector)
      expect(rendered).to have_css(password_selector)
      expect(rendered).to have_css(submit_selector)
    end

    it "shows a link to the forgotten password page" do
      stub_devise_helpers

      render

      expect(rendered).to have_css("a", exact_text: "Forgot your password?")
    end

    it "shows a sign up text" do
      stub_devise_helpers

      render

      expect(rendered).to(
        have_css("small", exact_text: "Don't have an account yet? Sign up.", normalize_ws: true)
      )
      expect(rendered).to have_link("Sign up", href: new_user_registration_path)
    end
  end
end
