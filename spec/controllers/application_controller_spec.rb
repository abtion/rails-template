# frozen_string_literal: true

require "rails_helper"

RSpec.describe ApplicationController, type: :controller do
  controller do
    def index
      raise CanCan::AccessDenied.new("Not authorized!", :manage, :all)
    end
  end

  describe "#access_denied" do
    context "when CanCan::AccessDenied error is risen" do
      it "handles it by rendering access_denied" do
        get :index

        expect(response).to have_http_status(:forbidden)
        expect(response.body).to eq("Not authorized!")
      end
    end
  end
end
