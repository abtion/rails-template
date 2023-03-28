# frozen_string_literal: true

require "rails_helper"

RSpec.describe ActiveStorage::DirectUploadsController do
  describe "#create" do
    it "creates a blob for direct upload" do
      user = create(:user)
      sign_in(user)

      post :create,
           params: { blob: { filename: "file.png", content_type: "image/png", byte_size: 10,
                             checksum: "aabbcc" } }

      expect(response.body).to include("file.png")
      expect(response).to have_http_status(:ok)
    end

    context "when user is unauthorized" do
      it "blocks the request" do
        post :create,
             params: { blob: { filename: "file.png", content_type: "image/png", byte_size: 10,
                               checksum: "aabbcc" } }

        expect(response.body).to include("Unauthorized")
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
