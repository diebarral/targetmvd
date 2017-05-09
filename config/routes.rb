Rails.application.routes.draw do

	root to: 'home#index'
	get 'users/sign_in', to: 'home#welcome'

	devise_for :users

	get 'home/welcome'
	get 'home/index'
	get 'home/load_sign_in', to: 'home#load_sign_in', as: 'load_sign_in'
	get 'home/load_sign_up', to: 'home#load_sign_up', as: 'load_sign_up'
	
	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	
end
