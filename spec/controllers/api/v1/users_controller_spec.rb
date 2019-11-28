# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::UsersController, type: :controller do
  describe "#show" do
    it "returns a 200 OK" do
      user = FactoryBot.create(:user)
      request.headers["Authorization"] = "Token #{user.authentication_token}"

      get :show, params: { id: user.id }

      expect(response.status).to eq(200)
    end
  end
end
