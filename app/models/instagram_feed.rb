class InstagramFeed < Feed 

  def find_or_create_post(feed_uid, post)
    @feed = Feed.find_by(uid: feed_uid)
    content = " "
    date = post.created_at
    Post.find_by(content: content) || Post.create(
      content: content,
      feed_id: @feed.id,
      date: date,
      feed_uid: feed_uid)
  end

  def self.get_user_media(id)
    Instagram.user_recent_media(id)
  end

  def profile_photo

  end




  def self.client
    Instagram.configure do |config|
      config.client_id = ENV["INSTAGRAM_CLIENT_KEY"]
      config.client_secret = ENV["INSTAGRAM_CLIENT_SECRET"]
      # config.access_token = ENV["INSTAGRAM_ACCESS_TOKEN"]
    end
  end

end