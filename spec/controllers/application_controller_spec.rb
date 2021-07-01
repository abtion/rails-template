# frozen_string_literal: true

require "rails_helper"

RSpec.describe ApplicationController, type: :controller do
  context "when Pundit::NotAuthorizedError error is risen" do
    controller do
      def index
        raise Pundit::NotAuthorizedError, "Not authorized!"
      end
    end

    describe "#access_denied" do
      it "handles it by rendering access_denied" do
        get :index

        expect(response).to have_http_status(:forbidden)
        expect(response.body).to eq("Not authorized!")
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
      allow(ENV).to receive(:[]).with("HTTP_AUTH_PASSWORD").and_return("a")

      get :index

      expect(response).to have_http_status(:unauthorized)
    end

    it "authenticates" do
      allow(ENV).to receive(:[]).with("HTTP_AUTH_USERNAME").and_return("a")
      allow(ENV).to receive(:[]).with("HTTP_AUTH_PASSWORD").and_return("b")
      request.env["HTTP_AUTHORIZATION"] =
        ActionController::HttpAuthentication::Basic.encode_credentials("a", "b")
      get :index

      expect(response).to have_http_status(:ok)
    end
  end
end
