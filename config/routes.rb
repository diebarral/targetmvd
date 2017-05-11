Rails.application.routes.draw do

  root to: 'home#index'

  devise_for :users

  resource :home do
    member do
      get 'load_sign_in', to: 'home#load_sign_in', as: 'load_sign_in'
      get 'load_sign_up', to: 'home#load_sign_up', as: 'load_sign_up'
    end
  end

  resource :targets do
    member do
      get 'load_create_form',  to: 'targets#load_create_form',as: 'load_create_form'
    end
  end
end
