# frozen_string_literal: true

require "rails_helper"

RSpec.describe UserSerializer, type: :serializer do
  it "only exposes a subset of the user's data" do
    user = create(:user)

    expect(UserSerializer.new(user).serializable_hash).to eq(data: {
                                                               attributes: {
                                                                 name: user.name
                                                               },
                                                               id: user.id,
                                                               type: :user
                                                             })
  end
end
