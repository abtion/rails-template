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

  if ENV.fetch("RAILS_ENV", "development") == "production"
    match "*unmatched", to: "errors#not_found", via: :all, constraints: lambda { |req|
      req.path.exclude?("rails/active_storage")
    }
  end
end
