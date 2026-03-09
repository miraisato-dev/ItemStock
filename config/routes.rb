# config/routes.rb
Rails.application.routes.draw do
  devise_for :users, controllers: {
  sessions: "users/sessions"
}

  # ゲストログイン用ルート
  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end

  resources :items
  root "items#index"

  get "up" => "rails/health#show", as: :rails_health_check

  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
