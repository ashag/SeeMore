class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :current_user
  before_action :tumblr_client, only: [:search]

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def search
    @twitter_client = TwitterFeed.client
    @page_num =
      if params[:page]
        params[:page].to_i
      else
        1
      end

    @user_name = params[:search]
    @search = @twitter_client.user_search(@user_name, page: @page_num).collect
    # I'm adding this logic because searching for a name with a space threw an error
    @user_name = @user_name.split.join
    @tumblr_blog_info = @tumblr_client.blog_info(@user_name)
    @tumblr_avatar = @tumblr_client.avatar(@user_name)
    render 'welcome/results'
  end

  private

  def tumblr_client
    Tumblr.configure do |config|
      config.consumer_key       = ENV["TUMBLR_CLIENT_ID"]
      config.consumer_secret    = ENV["TUMBLR_CLIENT_SECRET"]
      config.oauth_token        = ENV["TUMBLR_ACCESS_TOKEN"]
      config.oauth_token_secret = ENV["TUMBLR_ACCESS_TOKEN_SECRET"]
    end
    @tumblr_client = Tumblr::Client.new
  end
end

