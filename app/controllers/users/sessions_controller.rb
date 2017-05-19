class Users::SessionsController < Devise::SessionsController

  # POST /resource/sign_in
  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message!(:notice, :signed_in)
    sign_in(resource_name, resource)
    yield resource if block_given?
    cookies[:user_id] = current_user.id
    puts('USER ID EN COOKIE: ' + cookies[:user_id].to_s)
    respond_with resource, location: after_sign_in_path_for(resource)
  end
end
