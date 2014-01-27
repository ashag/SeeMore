class FeedsController < ApplicationController

  def create
    @feed = Feed.find_or_create(params)
    UserFeed.create_relationship(@feed, @current_user)
    uid = params[:uid].to_i
    @feed.class.get_posts(uid).each do |post|
      @feed.class.find_or_create_post(params[:uid], post)
    end

    redirect_to root_path
  end


end