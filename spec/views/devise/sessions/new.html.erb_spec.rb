# frozen_string_literal: true

require "rails_helper"

RSpec.describe "devise/sessions/new" do
  def stub_devise_helpers
    without_partial_double_verification do
      allow(view).to receive(:resource) { User.new }
      allow(view).to receive(:resource_name).and_return(:user)
      allow(view).to receive(:devise_mapping) { Devise.mappings[:user] }
    end
  end

  it "shows a remember me checkbox" do
    stub_devise_helpers

    render

    expect(rendered).to have_field("user[remember_me]", type: :checkbox)
  end

  context "with Danish locale" do
    around { |example| I18n.with_locale(:da) { example.run } }

    it "displays danish text" do
      stub_devise_helpers

      render

      expect(rendered).to have_css("h2", exact_text: "Log ind")
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

      expect(rendered).to have_link(exact_text: "Glemt dit kodeord?", normalize_ws: true)
    end
  end

  context "with English locale" do
    around { |example| I18n.with_locale(:en) { example.run } }

    it "displays English text" do
      stub_devise_helpers

      render

      expect(rendered).to have_css("h2", exact_text: "Sign in")
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

      expect(rendered).to have_link(exact_text: "Forgot your password?")
    end
  end
end
