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
      if @provider == "Twitter"
        twitter_search
      elsif @provider == "Tumblr"
        tumblr_search
      elsif @provider == "Github"
        github_search
      else
        twitter_search
        tumblr_search
        github_search
      end
    render 'welcome/results'
  end

  def rss_feed
    @feed_find = params[:search]
    @feed_results = Feedzirra::Feed.fetch_and_parse(params[:search])
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
      set_rss_posts
      redirect_to root_path, notice: "You added feed"
    # feed does not exist and user is not following
    else
      @feed = Feed.create(uid: @feed_find, type: 'RSSFeed')
      UserFeed.create_relationship(@feed, @current_user)
      set_rss_posts
      redirect_to root_path, notice: "Feed is added"
    end
  end

  def set_rss_posts
    @feed.get_posts(params[:search]).each do |post|
      @feed.find_or_create_post(@feed_find, post)
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
