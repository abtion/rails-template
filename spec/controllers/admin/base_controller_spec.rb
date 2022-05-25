# frozen_string_literal: true

require "rails_helper"

RSpec.describe Admin::BaseController, type: :controller do
  describe "#validate_admin" do
    controller do
      def index
        render template: "admin/users/index", layout: true
      end
    end

    context "when user is not admin" do
      it "handles it by rendering access_denied" do
        sign_in create(:user)

        get :index

        expect(flash[:alert]).to eq("Access not authorized")
        expect(response).to redirect_to(root_path)
      end
    end

    context "when user is admin" do
      it "allows access to admin area" do
        sign_in create(:user, :admin)

        get :index

        expect(response.status).to eq(200)
      end
    end
  end
end
