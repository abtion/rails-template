# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::BaseController, type: :controller do
  controller do
    before_action :require_authentication!

    def index
      render plain: "index called"
    end
  end

  describe "#index" do
    context "when invalid user id given" do
      it "returns a 401 unauthorized" do
        user = FactoryBot.create(:user)
        request.headers["X-User-Id"] = "nope"
        request.headers["Authorization"] = "Token #{user.authentication_token}"

        get :index

        expect(response).to have_http_status(:unauthorized)
      end
    end

    context "when no valid user id given" do
      it "returns a 401 unauthorized" do
        user = FactoryBot.create(:user)
        request.headers["Authorization"] = "Token #{user.authentication_token}"

        get :index

        expect(response).to have_http_status(:unauthorized)
      end
    end

    context "when invalid token given" do
      it "returns a 401 unauthorized" do
        user = FactoryBot.create(:user)
        request.headers["X-User-Id"] = user.id
        request.headers["Authorization"] = "Token 'nope'"

        get :index

        expect(response).to have_http_status(:unauthorized)
      end
    end

    context "when no valid token given" do
      it "returns a 401 unauthorized" do
        user = FactoryBot.create(:user)
        request.headers["X-User-Id"] = user.id

        get :index

        expect(response).to have_http_status(:unauthorized)
      end
    end

    context "when invalid token and user id given" do
      it "returns a 401 unauthorized" do
        request.headers["X-User-Id"] = "nope"
        request.headers["Authorization"] = "Token 'nope'"

        get :index

        expect(response).to have_http_status(:unauthorized)
      end
    end

    context "when no valid token and user id given" do
      it "returns a 401 unauthorized" do
        get :index

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
