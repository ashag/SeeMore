class TumblrFeed < Feed

  def get_user_link(id)
    @tumblr_client = TumblrClient.new_client
    get_blog(id)
    [@blog["blog"]["name"], "#{@blog.url}"]
  end

  def get_pic(uid)
    @tumblr_client = TumblrClient.new_client
    @avatar = @tumblr_client.avatar(uid)
  end

  def get_blog(name)
    @tumblr_client = TumblrClient.new_client
    @blog = @tumblr_client.blog_info(name)
  end

  def get_posts(id)
    @tumblr_client = TumblrClient.new_client
    get_blog(id)
    posts = []
    @tumblr_client.posts(@blog["blog"]["name"]).each do |post|
      posts << [post.timestamp, post.body]
    end
    posts
  end

end
