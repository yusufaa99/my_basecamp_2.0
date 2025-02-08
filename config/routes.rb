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
    
    get 'dashboard', to: 'dashboard#index', as: :dashboard
    get 'projects', to: 'projects#index', as: :projects
    get 'settings', to: 'settings#index', as: :settings
    get 'reports', to: 'reports#index', as: :reports
    get 'integrations', to: 'integrations#index', as: :integrations
    get 'security', to: 'security#index', as: :security
  end

  # Placeholder routes for other features:
  resources :projects, only: [:index]
  resources :tasks, only: [:index]
  resources :files, only: [:index]
  resources :messages, only: [:index]

  # Placeholder routes for Calendar, Settings, and Help:
  get 'calendar', to: 'calendar#index'
  get 'settings', to: 'settings#index'
  get 'help', to: 'help#index'


  # A simple home controller route (if needed)
  # get "home/index"
end
