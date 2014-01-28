class SessionsController < ApplicationController

  def create
    auth_hash = request.env['omniauth.auth']
    if auth_hash["uid"]
      @user = User.find_or_create_from_omniauth(auth_hash)

      if @user
        session[:user_id] = @user.id
        redirect_to root_path, notice: "You have successfully been signed in."
      else
        redirect_to root_path, notice: "Failed to save the user"
      end
    else
      redirect_to root_path, notice: "Failed to authenticate"
    end
  end

  def destroy
    reset_session
    redirect_to root_path, :notice => "You have been successfully signed out."
  end
end