# frozen_string_literal: true

require "sidekiq/web"

Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: "users/sessions"
  }

  namespace :admin do
    resources :users
  end

  mount Sidekiq::Web => "/sidekiq"

  namespace :api, defaults: { format: :json } do
    resources :users, only: :show
  end

  root to: "home#index"

  match "/404", to: "errors#not_found", via: :all
  match "/422", to: "errors#unprocessable_entity", via: :all
  match "/500", to: "errors#internal_server_error", via: :all
end
