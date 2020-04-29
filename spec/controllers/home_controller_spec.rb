# frozen_string_literal: true

require "rails_helper"

RSpec.describe HomeController, type: :controller do
  describe "#index" do
    it "renders 'abtion-rails'" do
      get :index

      expect(response).to have_http_status(:ok)
      expect(response.body).to eq("abtion-rails")
    end
  end
end
