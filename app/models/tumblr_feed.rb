class TumblrFeed < Feed

  def initialize
    super
    @tumblr_client = TumblrClient.new_client
  end

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

end
