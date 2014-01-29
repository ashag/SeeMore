class TwitterFeed < Feed

  def find_or_create_post(feed_uid, post)
    @feed = Feed.find_by(uid: feed_uid)
    tweet_link = get_user_link(feed_uid)
    content = "<img src='#{@feed.get_pic(feed_uid)}' alt='avatar for #{tweet_link[0]}'>
              <a href='#{tweet_link[1]}'> #{tweet_link[0]} </a>
              #{post.text}"
    date = post.created_at
    Post.find_by(content: content) || Post.create(
      content: content,
      feed_id: @feed.id,
      date: date,
      feed_uid: feed_uid)
  end

  def get_user_link(uid)
    get_tweeter(uid.to_i)
    [@tweeter.screen_name, "https://www.twitter.com/#{@tweeter.screen_name}"]
  end

  def get_pic(uid)
    get_tweeter(uid.to_i)
    @tweeter.profile_image_url
  end

  def get_tweeter(uid)
    @tweeter = TwitterFeed.client.user(uid.to_i)
  end

  def get_posts(uid)
    get_tweeter(uid.to_i)
    posts = []
    TwitterFeed.client.user_timeline(@tweeter).each do |tweet|
      posts << tweet
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

  def self.user_client(user)
    Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
      config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
      config.access_token        = user.token
      config.access_token_secret = user.secret
    end
  end
end
