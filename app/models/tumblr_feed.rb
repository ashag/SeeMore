class TumblrFeed < Feed
  before_action :client

  def get_user_link(id)
    get_blog(id)
    [@blog.name, "#{@blog.url}"]
  end

  def get_pic(id)
    @avatar = @tumblr_client.avatar(id)
  end

  def get_blog(id)
    @blog = @tumblr_client.blog_info(id)
  end

  def get_posts(id)
    get_blog(id)
    posts = []
    @tumblr_client.posts(@blog).each do |post|
      posts << [post.timestamp, post.body]
    end
    posts
  end

  def client
    Tumblr.configure do |config|
      config.consumer_key       = ENV["TUMBLR_CLIENT_ID"]
      config.consumer_secret    = ENV["TUMBLR_CLIENT_SECRET"]
      config.oauth_token        = ENV["TUMBLR_ACCESS_TOKEN"]
      config.oauth_token_secret = ENV["TUMBLR_ACCESS_TOKEN_SECRET"]
    end
    @tumblr_client = Tumblr::Client.new
  end
end
