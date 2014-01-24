class FeedsController < ApplicationController

def create
  @feed = Feed.find_or_create(params)
  UserFeed.create_relationship(@feed, @current_user)
  redirect_to root_path
end


end