class WelcomeController < ApplicationController
  before_action :twitter_client, only: [:index, :results]
  def index
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
