# frozen_string_literal: true

require "rails_helper"

RSpec.describe Admin::UsersController do
  let(:admin) { create(:user, :admin) }

  before do
    sign_in(admin)
  end

  describe "#index" do
    it "renders index and assigns users" do
      user = create(:user)

      get :index

      expect(response).to have_http_status(:ok)
      expect(assigns(:users)).to contain_exactly(user, admin)
    end
  end

  describe "#show" do
    it "renders show and assigns user" do
      user = create(:user)

      get :show, params: { id: user.id }

      expect(response).to have_http_status(:ok)
      expect(assigns(:user)).to eq(user)
    end
  end

  describe "#new" do
    it "renders new and assigns user" do
      new_user_mock = build(:user)
      allow(User).to receive(:new) { new_user_mock }

      get :new

      expect(response).to have_http_status(:ok)
      expect(assigns(:user)).to eq(new_user_mock)
    end
  end

  describe "#create" do
    context "with valid params" do
      it "creates new user" do
        valid_params = {
          user: {
            email: "test@email.com",
            name: "Muffi doge",
            password: "woof-SAYS-muffi",
            password_confirmation: "woof-SAYS-muffi"
          }
        }

        post :create, params: valid_params

        user = User.last

        expect(user.email).to eq("test@email.com")
        expect(user.name).to eq("Muffi doge")

        expect(flash[:notice]).to eq("Success!")
      end
    end

    context "with invalid params" do
      it "returns errors and flash alert" do
        stub_weak_password(password: "password", breach_count: 3_861_493)

        invalid_params = {
          user: {
            email: "test@email.com",
            password: "password"
          }
        }

        post :create, params: invalid_params

        user_errors = assigns(:user).errors.messages

        expect(flash[:alert]).to eq("Something went wrong, please try again")
        expect(response).to render_template(:new)
        expect(user_errors).to eq(
          {
            password: [
              "has previously appeared in data breaches 3861493 times and
              should never be used. Please choose something harder to guess.".squish
            ]
          }
        )
      end
    end
  end

  describe "#edit" do
    context "with valid params" do
      it "renders edit and assigns user" do
        user = create(:user)

        get :edit, params: { id: user.id }

        expect(response).to have_http_status(:ok)
        expect(assigns(:user)).to eq(user)
      end
    end
  end

  describe "#update" do
    context "with valid params" do
      it "updates user" do
        user = create(:user)

        valid_params = {
          id: user.id,
          user: {
            email: "test@email.com"
          }
        }

        put :update, params: valid_params

        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(admin_user_path(user))
        expect(user.reload.email).to eq("test@email.com")
        expect(flash[:notice]).to eq("Success!")
      end
    end

    context "when password fields filled in" do
      it "updates the password" do
        user = create(:user)

        valid_params = {
          id: user.id,
          user: {
            password: "woof-SAYS-muffi",
            password_confirmation: "woof-SAYS-muffi"
          }
        }

        put :update, params: valid_params

        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(admin_user_path(user))
        expect(user.reload.valid_password?("woof-SAYS-muffi")).to be(true)
        expect(flash[:notice]).to eq("Success!")
      end
    end

    context "with invalid params" do
      it "returns errors and renders edit" do
        user = create(:user, email: "initial@email.com")
        valid_params = {
          id: user.id,
          user: {
            email: "invalid email"
          }
        }

        put :update, params: valid_params

        user_errors = assigns(:user).errors.messages

        expect(flash[:alert]).to eq("Something went wrong, please try again")
        expect(user.reload.email).to eq("initial@email.com")
        expect(response).to render_template(:edit)
        expect(user_errors).to eq(
          {
            email: ["is invalid"]
          }
        )
      end
    end
  end

  describe "#destroy" do
    context "with valid params" do
      it "deletes user" do
        user = create(:user)

        delete :destroy, params: { id: user.id }

        expect(User.count).to eq(1)
        expect(flash[:notice]).to eq("Success!")
      end
    end

    context "with invalid params" do
      it "responds with alert" do
        user = create(:user)

        allow(User).to receive(:find)
          .with(user.id)
          .and_return(user)

        allow(user).to receive(:destroy).and_return(false)

        delete :destroy, params: { id: user.id }

        expect(User.count).to eq(2)
        expect(flash[:alert]).to eq("Something went wrong, please try again")
      end
    end
  end
end
