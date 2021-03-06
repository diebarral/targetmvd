Rails.application.routes.draw do

  get 'matches/get_messages'
  get 'notifications/index'
  get 'home/unread_messages_count', as: 'unread_messages_count'
  post 'matches/mark_as_read'
  post 'messages/create'

  mount ActionCable.server => '/cable'

  root to: 'home#index'

  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions', omniauth_callbacks: 'users/omniauth_callbacks' }

  resource :home do
    member do
      get 'load_sign_in', to: 'home#load_sign_in', as: 'load_sign_in'
      get 'load_sign_up', to: 'home#load_sign_up', as: 'load_sign_up'
      get 'load_edit', to: 'home#load_edit', as: 'load_edit'
      get 'welcome', to: 'home#welcome', as: 'welcome'
      get 'index', to: 'home#index', as: 'index'
    end
  end

  resource :targets do
    member do
      get 'list', to: 'targets#list', as: 'list'
      get 'load_create_form',  to: 'targets#load_create_form',as: 'load_create_form'
    end
  end
end
