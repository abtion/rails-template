# frozen_string_literal: true

require "rails_helper"

RSpec.describe ErrorsController, type: :controller do
  describe "GET #not_found" do
    it "renders 404 status page" do
      Rails.application.routes.draw { get "/not_found" => "errors#not_found" }

      get :not_found

      expect(response).to have_http_status(:not_found)

      Rails.application.reload_routes!
    end
  end
end
