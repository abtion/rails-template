# frozen_string_literal: true

require "rails_helper"

RSpec.describe BackLinkHelper do
  describe "#back_path" do
    context "when a back_path is sent via params" do
      it "returns the specified back path" do
        allow(params).to receive(:[]).with("back_path").and_return("https://back-path-param.com")
        allow(request).to receive(:referer).and_return("https://referer.com")

        expect(back_path(fallback: "https://fallback.com")).to eq("https://back-path-param.com")
      end
    end

    context "when referer header is available is sent via params" do
      it "returns the referer" do
        allow(self).to receive(:_filtered_referrer).and_return("https://referer.com")

        expect(back_path(fallback: "https://fallback.com")).to eq("https://referer.com")
      end
    end

    context "when only fallback is available" do
      it "returns the fallback" do
        expect(back_path(fallback: "https://fallback.com")).to eq("https://fallback.com")
      end
    end
  end

  describe "#back_path_field" do
    it "returns a hidden field specifying the back path" do
      allow(self).to receive(:back_path).and_return("https://back-path.com")

      subject = back_path_field

      expected_html_tag = <<~HTML.chomp
        <input type="hidden" name="back_path" id="back_path" value="https://back-path.com" autocomplete="off" />
      HTML

      expect(subject).to eq(expected_html_tag)
    end
  end
end
