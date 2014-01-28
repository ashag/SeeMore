class TumblrFeed < Feed

  def get_user_link(name)
    @tumblr_client = TumblrClient.new_client
    get_blog(name)
    [@blog["blog"]["name"], @blog["blog"]["url"]]
  end

  def get_pic(uid)
    @tumblr_client = TumblrClient.new_client
    @avatar = @tumblr_client.avatar(uid)
  end

  def get_blog(name)
    @tumblr_client = TumblrClient.new_client
    @blog = @tumblr_client.blog_info(name)
  end

  def get_posts(name)
    @tumblr_client = TumblrClient.new_client
    get_blog(name)

    posts = []

    @tumblr_client.posts(@blog["blog"]["name"])["posts"].each do |post|
      posts << [post["date"], post["post_url"]]
    end
    posts
  end

    def find_or_create_post(feed_uid, post)
    blog_link = get_user_link(feed_uid)

    content = "<h2> hello, this is a tumblr post</h2>"
    # content = "<%= image_tag(TumblrFeed.find_by_feed_uid(feed_uid).get_pic(feed_uid)) %>
    #           <%= link_to #{blog_link[0]}, #{blog_link[1]} %>
    #           <%= link_to #{post[1]}"
    date = post[0]
    @feed= Feed.find_by(uid: feed_uid)
    Post.find_by(content: content) || Post.create(
      content: content,
      feed_id: @feed.id,
      date: date,
      feed_uid: feed_uid)
  end



  private

  def find_post_type
  end

  def format_text_posts
  end

  def format_photo_posts
  end

  def format_quote_posts
  end

  def format_link_posts
  end

  def format_video_posts
  end

  def format_ask_posts
  end

end


# "posts"=>[
#   {"blog_name"=>"hello",
#   "id"=>74167153131,
#   "post_url"=>"http://hello.tumblr.com/post/74167153131/you-said-you-would-soon-do-a-raffle-for-your-url-are",
#   "slug"=>"you-said-you-would-soon-do-a-raffle-for-your-url-are",
#   "type"=>"answer",
#   "date"=>"2014-01-22 13:29:23 GMT",
#   "timestamp"=>1390397363,
#   "state"=>"published",
#   "format"=>"html",
#   "reblog_key"=>"qWVDwKOX",
#   "tags"=>[],
#    "short_url"=>"http://tmblr.co/ZSgZ0y154jF7h",
#     "highlighted"=>[],
#     "note_count"=>0,
#     "asking_name"=>"gosamer",
#     "asking_url"=>"http://gosamer.tumblr.com/",
#     "question"=>"You said you would soon do a raffle for your url. Are you still doing it?",
#      "answer"=>"<p>Is there a good way to do it? </p>"}
