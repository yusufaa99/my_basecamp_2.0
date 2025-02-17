Rails.application.routes.draw do
  root "home#index"
  get 'dashboard', to: 'dashboard#index'

  devise_for :users, controllers: { registrations: 'users/registrations' }
  resource :profile, only: [:edit, :update]

  namespace :admin do
    get 'dashboard', to: 'dashboard#index', as: :dashboard
    resources :users, only: [:index, :edit, :update, :destroy]
    resources :projects, only: [:index, :show, :edit, :update, :destroy]
    get 'settings', to: 'settings#index', as: :settings
    get 'reports', to: 'reports#index', as: :reports
    get 'integrations', to: 'integrations#index', as: :integrations
    get 'security', to: 'security#index', as: :security
  end
  

  
  resources :projects do
    resources :project_invitations, only: [:new, :create]
    resources :attachments, only: [:create, :destroy]
    resources :tasks
    resources :project_threads, only: [:new, :create, :show, :edit, :update, :destroy] do
      resources :messages, only: [:create, :edit, :update, :destroy]
    end
    
    member do
      patch "promote_to_admin/:user_id", to: "projects#promote_to_admin", as: :promote_to_admin
      patch "demote_to_member/:user_id", to: "projects#demote_to_member", as: :demote_to_member
      delete "remove_member/:user_id", to: "projects#remove_member", as: :remove_member
    end
  end
  

  resources :notifications, only: [:index, :destroy] do
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

  

  # Other placeholder routes...
  resources :files, only: [:index]

  get 'settings', to: 'settings#index'
  get 'calendar', to: 'calendar#index'
  get 'help', to: 'help#index'
  get 'pricing', to: 'static_pages#pricing', as: :pricing
  get 'about', to: 'static_pages#about', as: :about
  get 'blog', to: 'static_pages#blog', as: :blog
  get 'terms', to: 'static_pages#terms', as: :terms
  get 'search', to: 'static_pages#search', as: :search
  get "contact", to: "static_pages#contact", as: :contact
  post "contact", to: "static_pages#send_message"

end
