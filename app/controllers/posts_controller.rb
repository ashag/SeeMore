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

    begin
      client.favorite!(tweet)
      redirect_to :back, notice: "Tweet has been favorited!"
    rescue Twitter::Error::AlreadyFavorited => e
      redirect_to :back, alert: "You already favorited this tweet."
    end

  end

  def retweet

  end

end