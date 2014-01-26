class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :current_user
  before_action :twitter_client, only: [:search, :next_search_page]
  before_action :tumblr_client, only: [:search]

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
    tumblr_search(@user_name)
    render 'welcome/results'
  end

  def rss_feed
    @feed_search = params[:search]
    feed = Feedzirra::Feed.fetch_and_parse("#{@feed_search}")
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

  def tumblr_client
    Tumblr.configure do |config|
      config.consumer_key       = ENV["TUMBLR_CLIENT_ID"]
      config.consumer_secret    = ENV["TUMBLR_CLIENT_SECRET"]
      config.oauth_token        = ENV["TUMBLR_ACCESS_TOKEN"]
      config.oauth_token_secret = ENV["TUMBLR_ACCESS_TOKEN_SECRET"]
    end
    @tumblr_client = Tumblr::Client.new
  end


  def tumblr_search(user_name)
    @tumblr_search_term = @user_name.delete(' ')
    @tumblr_blog_info = @tumblr_client.blog_info(@tumblr_search_term)
    @tumblr_avatar = @tumblr_client.avatar(@tumblr_search_term)
    @tumblr_blog_info
    @tumblr_avatar
  end
end

