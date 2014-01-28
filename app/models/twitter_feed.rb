class TwitterFeed < Feed

  def find_or_create_post(feed_uid, post)
    tweet_link = get_user_link(feed_uid)
    # Write as HTML
    content = "<% image_tag(#{}Feed.get_pic(feed_uid) %>
              <%= link_to #{user_array[0]}, #{user_array[1]} %>
              <%= #{post.text}%>"
    date = post.created_at
    @feed = Feed.find_by(uid: feed_uid)
    Post.find_by(content: content) || Post.create(
      content: content,
      feed_id: @feed.id,
      date: date,
      feed_uid: feed_uid)
  end

  def get_user_link(id)
    get_tweeter(id.to_i)
    [@tweeter.screen_name, "https://www.twitter.com/#{@tweeter.screen_name}"]
  end

  def get_tweeter(id)
    @tweeter = TwitterFeed.client.user(id.to_i)
  end

  def get_posts(id)
    get_tweeter(id.to_i)
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
end
