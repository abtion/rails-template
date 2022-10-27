# frozen_string_literal: true

require "rails_helper"

RSpec.describe ApplicationHelper do
  describe "#field_error" do
    context "when errors are present" do
      it "returns error messages in content tag" do
        user = build(:user, email: nil)
        user.valid?
        expected_html_tag = [
          "<div>",
          "<p class=\"text-danger-800 text-sm\">Email can&#39;t be blank.</p>",
          "</div>"
        ].join

        subject = field_error(field: :email, resource: user)
        expect(subject).to eq(expected_html_tag)
      end
    end

    context "when there are no errors" do
      it "returns nothing" do
        user = build(:user)
        user.valid?
        subject = field_error(field: :email, resource: user)

        expect(subject).to be_nil
      end
    end
  end
end
