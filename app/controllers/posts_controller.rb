class PostsController < ApplicationController

  def tweet
    client = TwitterFeed.user_client(@current_user)
    client.update(params[:tweet])
    redirect_to root_path, notice: "Your tweet is a SUCCESS!"
  end

# Write in logic for re-favoriting error.

  def favorite
    client = TwitterFeed.user_client(@current_user)
    tweet = client.status(params[:twitter_id])
    client.favorite!(tweet)
    redirect_to root_path, notice: "Tweet has been favorited!"
  end

  def retweet

  end

end