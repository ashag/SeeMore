class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :current_user
  before_action :twitter_client, only: [:search, :next_search_page]

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def search
    @page_num =
      if params[:page]
        params[:page].to_i
      else
        1
      end

    @user_name = params[:search]
    @search = @twitter_client.user_search(@user_name, page: @page_num).collect
    # Replacing old search for now.
    render 'welcome/results'
  end

  private
  def twitter_client
    @twitter_client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
      config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
      config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
      config.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"]
    end
  end
end
