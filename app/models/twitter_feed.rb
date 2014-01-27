class TwitterFeed < Feed

  def find_or_create_post(feed_id, post)
    user_array = get_user_link(feed_id)
    content = "<% image_tag(#{}Feed.get_pic(feed_id) %>
              <%= link_to #{user_array[0]}, #{user_array[1]} %>
              <%= #{post.text}"
    date = post.created_at
    Post.find_by(content: content) || Post.create(content: content, feed_id: feed_id, date: date)
  end

  def get_user_link(id)
    get_user(id)
    [@user.screen_name, "https://www.twitter.com/#{@user.screen_name}"]
  end

  def get_user(id)
    @user = TwitterFeed.client.user(id.to_i)
  end

  def get_posts(id)
    @user = self.get_user(id.to_i)
    posts = []
    TwitterFeed.client.user_timeline(@user).each do |tweet|
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
