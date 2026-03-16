# config/routes.rb
Rails.application.routes.draw do
  get "dashboard/index"
  devise_for :users, controllers: {
    sessions: "users/sessions"
  }

  # ゲストログイン
  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end

  resources :items do
    collection do
      get :dashboard
      get :before_listing
      get :listed
      get :sold
    end
  end

  root "items#dashboard"
  get "dashboard", to: "items#dashboard"

  get "up" => "rails/health#show", as: :rails_health_check

  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end