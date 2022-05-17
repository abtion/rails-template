# frozen_string_literal: true

require "sidekiq/web"
require "constraints/api_version"

Rails.application.routes.draw do
  devise_for :users

  mount Sidekiq::Web => "/sidekiq"

  namespace :api, defaults: { format: :json } do
    scope module: :v1, constraints: Constraints::ApiVersion.new("v1") do
      resources :users, only: :show
    end
  end

  root to: "home#index"

  match "*unmatched", to: "errors#not_found", via: :all
end
