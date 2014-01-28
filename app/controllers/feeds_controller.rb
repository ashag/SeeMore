class FeedsController < ApplicationController

  def create
    @feed = Feed.find_or_create(params)
    UserFeed.create_relationship(@feed, @current_user)

    uid = params[:uid]
    @feed.get_posts(uid).each do |post|
      @feed.find_or_create_post(params[:uid], post)
    end
    redirect_to root_path
  end

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

 def rss_feed
    @feed_find = params[:search]
    @feed_results = Feedzirra::Feed.fetch_and_parse(@feed_find)
    @feed = Feed.find_by(uid: @feed_find)

    # feed exists and User is following feed
    if @feed != nil && UserFeed.following?(@current_user.id, @feed.uid).count != 0
      redirect_to root_path, notice: "This feed is already your prey"
    # feed url is invalid
    elsif @feed_results == 0
      redirect_to root_path, notice: "Invalid feed URL. Please try again."
    # feed exists and user is not following
    elsif @feed != nil
      UserFeed.create_relationship(@feed, @current_user)
      redirect_to root_path, notice: "You added feed"
    # feed does not exist and user is not following
    else
      create_rss = Feed.create(uid: @feed_find, type: 'RSSFeed')
      UserFeed.create_relationship(create_rss, @current_user)
      redirect_to root_path, notice: "Feed is added"
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


end
