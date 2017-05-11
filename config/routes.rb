Rails.application.routes.draw do

	root to: 'home#index'
	#	get 'users/sign_in', to: 'home#welcome'

	devise_for :users

	get 'home/load_sign_in', to: 'home#load_sign_in', as: 'load_sign_in'
	get 'home/load_sign_up', to: 'home#load_sign_up', as: 'load_sign_up'
	get 'targets/load_create_target', to: 'targets#load_create_target', as: 'load_create_target'

	resources :home, :targets
	# get 'home/welcome'
	# get 'home/index'

	# get 'targets/index', to: 'targets#index', as: 'targets'
	# get 'targets/new', to: 'targets#new'
	# post 'targets/create', to: 'targets#create'



	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
