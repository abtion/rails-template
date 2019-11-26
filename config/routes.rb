# frozen_string_literal: true

require "constraints/api_version"

Rails.application.routes.draw do
  devise_for :users

  namespace :api, defaults: { format: :json } do
    scope module: :v1, constraints: Constraints::ApiVersion.new("v1", true) do
      resources :users, only: :show
    end
  end

  root to: "home#index"
end
