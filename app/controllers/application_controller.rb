class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def search
    user_name = params[:search]
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = "4ZAESuILP0GXfv3MvGIh9g"
      config.consumer_secret     = "B2pFG63VtYoUBNwZi8T37XhBHmTp9zxKgNbkswiyc"
      config.access_token        = "2305620871-17k90hzVPJmaNRpDOpbZGGuw1F2mkiwmCViyXCm"
      config.access_token_secret = "gmDn7WKp2QvBOUUCarNf42atJlWEQ5lyi0PZlQOLjGhnm"
    end
    @search = client.search(user_name, :count => 10).take(10).collect do |tweet|
      "#{tweet.user.screen_name}: #{tweet.text}"
    end
    puts @search
    render 'welcome/results'
  end

end
