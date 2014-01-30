class PostsController < ApplicationController

  def tweet
    client = TwitterFeed.user_client(@current_user)
    client.update(params[:tweet])
    redirect_to root_path, notice: "Your tweet is a SUCCESS!"
  end

end