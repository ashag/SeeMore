class TumblrFeed < Feed

  def get_user_link(id)
    @tumblr_client = TumblrClient.new_client
    get_blog(id)
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

  def get_posts(id)
    @tumblr_client = TumblrClient.new_client
    get_blog(id)

    posts = []

    @tumblr_client.posts(@blog["blog"]["name"])["posts"].each do |post|
      posts << [post["date"], post["post_url"]]
    end
    posts
  end

    def find_or_create_post(feed_uid, post)
    blog _link = get_user_link(feed_uid)
    content = "<% image_tag(TumblrFeed.find_by_feed_uid(feed_uid).get_pic(feed_uid)) %>
              <%= link_to #{blog_link[0]}, #{blog_link[1]} %>
              <%= #{post[1]}"
    date = post[0]
    uid = Feed.find_by(feed_id).uid
    Post.find_by(content: content) || Post.create(
      content: content,
      feed_id: feed_id,
      date: date,
      feed_uid: uid)
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
