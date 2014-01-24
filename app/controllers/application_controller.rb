class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :current_user
  before_action :twitter_client, only: [:search]

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def search
    user_name = params[:search]
    @search = @client.user_search(user_name, count: 50).collect
    @tumblr_search = @tumblr_client.posts("#{user_name}.tumblr.com")
    render 'welcome/results'
  end

  private
  def twitter_client
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
      config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
      config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
      config.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"]
    end
  end

  def tumblr_client
    @tumblr_client = Tumblr::Client.new do |config|
      config.consumer_key       = ENV["TUMBLR_CONSUMER_KEY"]
      config.consumer_secret    = ENV["TUMBLR_CONSUMER_SECRET"]
      config.oauth_token        = ENV["TUMBLR_ACCESS_TOKEN"]
      config.oauth_token_secret = ENV["TUMBLR_ACCESS_TOKEN_SECRET"]
    end
  end
end

