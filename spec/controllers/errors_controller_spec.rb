# frozen_string_literal: true

require "rails_helper"

RSpec.describe ErrorsController do
  describe "GET #not_found" do
    context "when request has no referer" do
      it "renders 404 status page and does not send warning to Rollbar" do
        allow(Rollbar).to receive(:warning)
        Rails.application.routes.draw { get "/not_found" => "errors#not_found" }

        get :not_found

        expect(response).to have_http_status(:not_found)
        expect(Rollbar).to_not(have_received(:warning))

        Rails.application.reload_routes!
      end
    end

    context "when request has a referer" do
      it "renders 404 status page and sends warning to Rollbar" do
        allow(Rollbar).to receive(:warning).and_return("success")
        Rails.application.routes.draw { get "/not_found" => "errors#not_found" }

        controller.request.headers.merge({ HTTP_REFERER: "https://example.com/" })

        get :not_found

        expect(response).to have_http_status(:not_found)
        expect(Rollbar).to have_received(:warning).with("RoutingError: No route matches [GET] 'http://test.host/not_found'")

        Rails.application.reload_routes!
      end
    end
  end

  context "when route includes ignored route pattern" do
    it "renders 404 status page and does not send warning to Rollbar" do
      allow(Rollbar).to receive(:warning)

      Rails.application.routes.draw do
        get "/test.php" => "errors#not_found"
      end

      controller.request.headers.merge({ HTTP_REFERER: "https://example.com/" })

      get :not_found, params: { use_route: "/test.php" }

      expect(response).to have_http_status(:not_found)
      expect(Rollbar).to_not(have_received(:warning))

      Rails.application.reload_routes!
    end
  end
end
