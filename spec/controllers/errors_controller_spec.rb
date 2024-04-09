# frozen_string_literal: true

require "rails_helper"

RSpec.describe ErrorsController, type: :controller do
  render_views

  describe "GET #not_found" do
    it "renders 404 status page" do
      get :not_found

      expect(response).to have_http_status(:not_found)
      expect(response.body).to match("404")
    end
  end

  describe "GET #unprocessable_entity" do
    it "renders 422 status page" do
      get :unprocessable_entity

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.body).to match("422")
    end
  end

  describe "GET #internal_server_error" do
    it "renders 422 status page" do
      get :internal_server_error

      expect(response).to have_http_status(:internal_server_error)
      expect(response.body).to match("500")
    end
  end
end
