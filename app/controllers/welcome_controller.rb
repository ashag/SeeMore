class WelcomeController < ApplicationController
  before_action :twitter_client

  def index
  end

  def signin
  end

  def results
  end

# this is not DRY--it's the same as a method in the application controller.
# I am just putting this method in here for testing purposes.
  private
    def twitter_client
    @twitter_client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
      config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
      config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
      config.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"]
    end
  end
end