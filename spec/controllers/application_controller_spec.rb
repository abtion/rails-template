# frozen_string_literal: true

require "rails_helper"

RSpec.describe ApplicationController do
  context "when Pundit::NotAuthorizedError error is risen" do
    controller do
      def index
        raise Pundit::NotAuthorizedError, "Access not authorized"
      end
    end

    describe "#access_denied" do
      it "handles it by rendering access_denied" do
        get :index

        expect(flash[:alert]).to eq("Access not authorized")
        expect(response).to redirect_to(root_path)
      end
    end
  end

  context "when InvalidAuthenticityToken error is risen" do
    controller do
      def index
        raise ActionController::InvalidAuthenticityToken
      end
    end

    describe "#invalid_authenticity_token" do
      it "handles it by redirecting back and displaying flash alert" do
        get :index

        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to eq("Your session has expired. Please try again.")
      end
    end
  end

  describe "#basic_auth_wall" do
    controller do
      def index
        render html: ""
      end
    end

    it "requires authentication if ENV HTTP_AUTH_PASSWORD is set" do
      allow(ENV).to receive(:fetch).with("HTTP_AUTH_PASSWORD", nil).and_return("a")

      get :index

      expect(response).to have_http_status(:unauthorized)
    end

    it "authenticates" do
      allow(ENV).to receive(:fetch).with("HTTP_AUTH_USERNAME").and_return("a")
      allow(ENV).to receive(:fetch).with("HTTP_AUTH_PASSWORD", nil).and_return("a")
      allow(ENV).to receive(:fetch).with("HTTP_AUTH_PASSWORD").and_return("b")
      request.env["HTTP_AUTHORIZATION"] =
        ActionController::HttpAuthentication::Basic.encode_credentials("a", "b")
      get :index

      expect(response).to have_http_status(:ok)
    end
  end
end
