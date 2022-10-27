# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::UsersController do
  describe "#show" do
    it "returns a 200 OK" do
      user = create(:user)
      request.headers["X-User-Id"] = user.id
      request.headers["Authorization"] = "Token #{user.authentication_token}"

      get :show, params: { id: user.id }

      expect(response).to have_http_status(:ok)
    end
  end
end
