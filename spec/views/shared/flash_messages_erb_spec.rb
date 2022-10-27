# frozen_string_literal: true

require "rails_helper"

RSpec.describe "shared/flash_messages" do
  context "when flash is alert" do
    it "renders flash_messages partial" do
      expected_message = t("devise.sessions.signed_out")
      flash[:alert] = expected_message

      render partial: "shared/flash_messages"

      expect(rendered).to have_css("div[data-react-component='FlashMessage']")
      expect(rendered).to match("danger")
      expect(rendered).to match(expected_message)
    end
  end

  context "when flash is warning" do
    it "renders flash_messages partial" do
      expected_message = t("devise.sessions.warn_pwned.one")
      flash[:warning] = expected_message

      render partial: "shared/flash_messages"

      expect(rendered).to have_css("div[data-react-component='FlashMessage']")
      expect(rendered).to match("warning")
      expect(rendered).to match(expected_message)
    end
  end

  context "when flash is notice" do
    it "renders flash_messages partial" do
      expected_message = t("devise.sessions.signed_in")
      flash[:notice] = expected_message

      render partial: "shared/flash_messages"

      expect(rendered).to have_css("div[data-react-component='FlashMessage']")
      expect(rendered).to match("success")
      expect(rendered).to match(expected_message)
    end
  end
end
