class PostsController < ApplicationController

  def tweet
    client = TwitterFeed.user_client(@current_user)
    client.update(params[:tweet])
    redirect_to root_path, notice: "Your tweet is a SUCCESS!"
  end

  def favorite
    client = TwitterFeed.user_client(@current_user)
    tweet = client.status(params[:twitter_id])
    client.favorite(tweet)
    redirect_to root_path
  end


  def retweet

  end

end