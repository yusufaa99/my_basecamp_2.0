Rails.application.routes.draw do
  root "home#index"
  get 'dashboard', to: 'dashboard#index'

  # Devise routes (using custom registrations controller for extra parameters)
  devise_for :users, controllers: { registrations: 'users/registrations' }

  # Profile editing (for current user)
  resource :profile, only: [:edit, :update]

  # Admin user management routes
  namespace :admin do
    resources :users, only: [:index, :edit, :update, :destroy]
  end

end
