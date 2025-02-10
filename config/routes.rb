Rails.application.routes.draw do
  get "attachments/create"
  get "attachments/destroy"
  root "home#index"
  get 'dashboard', to: 'dashboard#index'

  devise_for :users, controllers: { registrations: 'users/registrations' }
  resource :profile, only: [:edit, :update]

  namespace :admin do
    get 'dashboard', to: 'dashboard#index', as: :dashboard
    resources :users, only: [:index, :edit, :update, :destroy]
    get 'projects', to: 'projects#index', as: :projects
    get 'settings', to: 'settings#index', as: :settings
    get 'reports', to: 'reports#index', as: :reports
    get 'integrations', to: 'integrations#index', as: :integrations
    get 'security', to: 'security#index', as: :security
  end

  # Nest discussion threads under projects for creation
  resources :projects do
    resources :discussion_threads, only: [:index, :new, :create]
    resources :project_invitations, only: [:new, :create]
    resources :attachments, only: [:create, :destroy]
  end

  resources :notifications, only: [:index] do
    member do
      patch :mark_as_read
    end
  end
  
  # Route for viewing invitations for the current user
  get 'invitations', to: 'invitations#index', as: :invitations
  
  # Routes for accepting or declining an invitation.
  # These routes assume you'll use the invitation token for lookup.
  get 'invitations/accept/:token', to: 'invitations#accept', as: :accept_invitation
  get 'invitations/decline/:token', to: 'invitations#decline', as: :decline_invitation

  # Standalone routes for threads (for show, edit, update, destroy)
  resources :discussion_threads, only: [:show, :edit, :update, :destroy] do
    resources :messages, only: [:create, :edit, :update, :destroy]
  end

  # Other placeholder routes...
  resources :tasks, only: [:index]
  resources :files, only: [:index]
  resources :messages, only: [:index]
  get 'settings', to: 'settings#index'

  get 'calendar', to: 'calendar#index'
  get 'help', to: 'help#index'
  get 'pricing', to: 'static_pages#pricing', as: :pricing
  get 'about', to: 'static_pages#about', as: :about
  get 'blog', to: 'static_pages#blog', as: :blog
  get 'contact', to: 'static_pages#contact', as: :contact
  get 'terms', to: 'static_pages#terms', as: :terms
  get 'search', to: 'static_pages#search', as: :search
end
