class TwitterFeed < Feed

  def find_or_create_post(feed_uid, post)
    unless feed_uid.nil? || post.nil?
      @feed = Feed.find_by(uid: feed_uid)
      tweet_link = get_user_link(feed_uid)
    end
    unless tweet_link.nil? || feed_uid.nil? || post.nil?
      content = "<table>
                <tr>
                  <td style='padding-right: 10px'><img src='#{@feed.get_pic(feed_uid)}' alt='avatar for #{tweet_link[0]}' class=\"img-rounded\"></td>
                  <td><b><a href='#{tweet_link[1]}'> #{tweet_link[0]} </a></b><br>
                #{post.text}</td>
                </tr>
                </table><br>"
      twitter_id = post.id.to_s
      datetime = post.created_at
      Post.find_by(content: content) || Post.create(
        content: content,
        feed_id: @feed.id,
        twitter_id: twitter_id,
        datetime: datetime,
        feed_uid: feed_uid)
    end
    rescue Twitter::Error::TooManyRequests
  end

  def get_user_link(uid)
    unless uid.nil?
      unless get_tweeter(uid.to_i).nil?
        [@tweeter.screen_name, "https://www.twitter.com/#{@tweeter.screen_name}"]
      end
    end
    rescue Twitter::Error::TooManyRequests
  end

  def get_pic(uid)
    unless uid.nil?
      unless get_tweeter(uid.to_i).nil?
        @tweeter.profile_image_url
      end
    end
    rescue Twitter::Error::TooManyRequests
  end

  def get_tweeter(uid)
    unless uid.nil?
      @tweeter = TwitterFeed.client.user(uid.to_i)
    end
    rescue Twitter::Error::TooManyRequests
  end

  def get_posts(uid)
    unless uid.nil?
      unless get_tweeter(uid.to_i).nil?
        posts = []
        TwitterFeed.client.user_timeline(@tweeter).each do |tweet|
          posts << tweet
        end
      end
    end
    if posts.nil
      return ['', '']
    else
      posts
    end
    rescue Twitter::Error::TooManyRequests
  end

  def self.client
    @twitter_client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
      config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
      config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
      config.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"]
    end
  end

  def self.build_user_feed(user, page)
    if page.nil?
      page = 1
    else
      page = page.to_i
    end
    client = TwitterFeed.user_client(user)
    tweets = client.home_timeline(page: page)
    tweets.each do |tweet|
      feed = Feed.find_or_create({uid: tweet.user.id.to_s, type: "TwitterFeed"})
      UserFeed.find_or_create(feed, user)
      feed.find_or_create_post(feed.uid, tweet)
    end
    rescue Twitter::Error::TooManyRequests
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
