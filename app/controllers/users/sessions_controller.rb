class Users::SessionsController < Devise::SessionsController

  # POST /resource/sign_in
  def create
    super
    cookies[:user_id] = current_user.id
  end

  # DELETE /resourece
  def destroy
    super
    cookies.delete :user_id
  end
end
