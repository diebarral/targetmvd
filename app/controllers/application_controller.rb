class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_sign_up_params, if: :devise_controller?, only: [:create]

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :gender])
  end

  def after_sign_in_path_for(resource)
  	index_home_path
  end

  def after_sign_out_path_for(resource)
  	welcome_home_path
  end

  def after_sign_up_path_for(resource)
    index_home_path
  end

end
