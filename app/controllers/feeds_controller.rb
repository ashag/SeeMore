class FeedsController < ApplicationController

  def create
    @feed = Feed.find_or_create(params)
    UserFeed.create_relationship(@feed, @current_user)
    @feed.get_posts(params[:uid]).each do |post|
      @feed.find_or_create_post(params[:uid], post)
    end
    redirect_to root_path
  end

  def search
    @provider = params[:provider]
    @user_name = params[:search]
      if @user_name.nil? || @user_name == ''
      redirect_to '/'
      elsif @provider == "Twitter"
        twitter_search
      elsif @provider == "Tumblr"
        tumblr_search
      elsif @provider == "Github"
        github_search
      elsif @provider == "Instagram"
        insta_search 
      else
        twitter_search
        tumblr_search
        github_search
        insta_search
      end
    render 'welcome/results'
    rescue Twitter::Error::TooManyRequests
  end


  def insta_search
    InstagramFeed.client
    @instagram_search = Instagram.user_search(params[:search])
  end

  def feed
    unless params[:page]
      params[:page] = 1
    end
  end

  def rss_feed
    @feed_find = params[:search]
    @feed_results = Feedzirra::Feed.fetch_and_parse(@feed_find)
    @feed = Feed.find_by(uid: @feed_find)

    if @feed != nil && UserFeed.rss_following?(@current_user.id, @feed)
      redirect_to root_path, notice: "This feed is already your prey"
    elsif @feed_results == 0 || @feed_results == 404
      redirect_to root_path, notice: "Invalid feed URL. Please try again."
    elsif @feed != nil
      UserFeed.create_relationship(@feed, @current_user)
      set_rss_posts
      redirect_to root_path, notice: "You added feed"
    else
      @feed = Feed.create(uid: @feed_find, type: 'RSSFeed')
      UserFeed.create_relationship(@feed, @current_user)
      set_rss_posts
      redirect_to root_path, notice: "Feed is added"
    end
  end

  def set_rss_posts
    @feed.get_posts(@feed.uid).each do |post|
      @feed.find_or_create_post(@feed.uid, post)
    end
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


  def github_search
    @github_search_term = @user_name.delete(' ')
    @github_user = GithubFeed.search(@github_search_term)
  end
end
