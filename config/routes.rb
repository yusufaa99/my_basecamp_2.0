Rails.application.routes.draw do
  root "home#index"

  # Devise routes (using custom registrations controller for extra parameters)
  devise_for :users, controllers: { registrations: 'users/registrations' }

  # Profile editing (for current user)
  resource :profile, only: [:edit, :update]

  # Admin user management routes
  namespace :admin do
    resources :users, only: [:index, :edit, :update, :destroy]
  end

  # A simple home controller route (see below)
  get "home/index"
end
