# frozen_string_literal: true

require "rails_helper"

RSpec.describe HomeController do
  describe "#index" do
    it "is ok" do
      get :index

      expect(assigns(:test)).to eq("test")
      expect(response).to have_http_status(:ok)
    end
  end
end
