class WelcomeController < ApplicationController
  before_action :twitter_client, only: [:index, :results]
  def index
    @feed = Feed.sort_feed(@current_user.id)
  end

  def signin
  end

  def results
  end

  private
  def twitter_client
    @twitter_client = TwitterFeed.client
  end
end
