class TwitterFeed < Feed
  def get_user_link(id)
    get_user(id)
    [@user.screen_name, "https://www.twitter.com/#{@user.screen_name}"]
  end

  def get_pic(id)
    get_user(id)
    "#{@user.profile_image_url}"
  end

  def get_user(id)
    @user = TwitterFeed.client.user(id.to_i)
  end

  def get_posts(id)
    @twitter_client = TwitterFeed.client
    get_user(id)
    posts = []
    @twitter_client.user_timeline(@user).each do |tweet|
      posts << [tweet.created_at, tweet.text]
    end
    posts
  end

  def self.client 
    @twitter_client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
      config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
      config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
      config.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"]
    end
  end
end
