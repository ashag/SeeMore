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
    @provider = params[:provider]
    @user_name = params[:search]
      if @provider == "Twitter"
        twitter_search
      elsif @provider == "Tumblr"
        tumblr_search
      else
        twitter_search
        tumblr_search
      end
    render 'welcome/results'
  end

  private
    def twitter_search
      @twitter_client = TwitterFeed.client
      @page_num =
        if params[:page]
          params[:page].to_i
        else
          1
        end
      @search = @twitter_client.user_search(@user_name, page: @page_num).collect
    end

  def tumblr_search
    @tumblr_client = TumblrClient.new_client
    @tumblr_search_term = @user_name.delete(' ')
    @tumblr_blog_info = @tumblr_client.blog_info(@tumblr_search_term)
    @tumblr_avatar = @tumblr_client.avatar(@tumblr_search_term)
  end

end

