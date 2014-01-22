class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def search
    user_name = params[:search]
    @search = HTTParty.get("https://api.twitter.com/1.1/users/lookup.json?screen_name=#{user_name}")
    puts @search
    redirect_to root_path
  end

end
