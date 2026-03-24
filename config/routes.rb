# config/routes.rb
Rails.application.routes.draw do
  get "home/index"

  devise_for :users, controllers: {
                       sessions: "users/sessions",
                     }

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

  resources :users, only: [:new, :create, :edit, :update]

  get "profile", to: "users#profile"
  patch "profile", to: "users#update_profile"

  get "account", to: "users#account"
  patch "account", to: "users#update_account"

  get "edit_account", to: "users#edit_account"
  patch "update_account", to: "users#update_account"

  get "edit_profile", to: "users#edit_profile"
  patch "update_profile", to: "users#update_profile"

  root "home#index"

  get "dashboard", to: "items#dashboard"
end
