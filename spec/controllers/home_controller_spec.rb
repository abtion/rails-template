# frozen_string_literal: true

require "rails_helper"

RSpec.describe HomeController, type: :controller do
  describe "#index" do
    it "renders 'abtion-rails'" do
      user = FactoryBot.create(:user)
      request.headers["X-User-Id"] = user.id
      request.headers["Authorization"] = "Token #{user.authentication_token}"

      get :index, params: { id: user.id }

      expect(response.body).to eq("abtion-rails")
    end
  end
end
