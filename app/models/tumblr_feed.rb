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
     posts << post
    end
    posts
  end

    def find_or_create_post(feed_uid, post)
    content = find_post_type(feed_uid, post)
    date = post["date"]
    @feed = Feed.find_by(uid: feed_uid)
    Post.find_by(content: content) || Post.create(
      content: content,
      feed_id: @feed.id,
      date: date,
      feed_uid: feed_uid)
  end



  private

  def find_post_type(feed_uid, post)
    type = post["type"]

    if type == "text"
      format_text_post(feed_uid, post)
    elsif type == "photo"
      format_photo_post(feed_uid, post)
    elsif type == "link"
      format_link_post(feed_uid, post)
    elsif type == "quote"
      format_quote_post(feed_uid, post)
    elsif type == "chat"
      format_chat_post(feed_uid, post)
    elsif type == "answer"
      format_answer_post(feed_uid, post)
    elsif type == "audio"
      format_audio_post(feed_uid, post)
    else
      format_video_post(feed_uid, post)
    end
  end

  def format_text_post(feed_uid, post)
    blog_link = get_user_link(feed_uid)
    get_pic(uid)
    body = post["body"]
    post_url = post["short_url"]
    title = post["title"]
    content = "<hr><img src=\"#{@avatar}\"/><a href=\"#{blog_link[1]}>#{blog_link[0]}</a>
                    <h4><a href=\"#{post_url}\">#{title}</a></h4><p>#{body}</p><hr>"
      return content
  end

  def format_photo_post(feed_uid, post)
    blog_link = get_user_link(feed_uid)
    get_pic(uid)
    body = post["body"]
    post_url = post["short_url"]
    photo = post["photos"][0]["alt_sizes"][1]["url"]
    caption = post["caption"]
    content = "<hr><img src=\"#{@avatar}\"/><a href=\"#{blog_link[1]}>#{blog_link[0]}</a>
                      #{photo}
                    <h4><a href=\"#{post_url}\">#{caption}</a></h4><hr>"
      return content
  end

  def format_quote_post(feed_uid, post)
    blog_link = get_user_link(feed_uid)
    get_pic(uid)
    body = post["body"]
    post_url = post["short_url"]
    quote = post["text"]
    source = post["source"]
    content = "<hr><img src=\"#{@avatar}\"/><a href=\"#{blog_link[1]}>#{blog_link[0]}</a>
                      <h4><a href=\"#{post_url}\">#{quote}</a></h4>#{source}<hr>"
      return content
  end

  def format_link_post(feed_uid, post)
    blog_link = get_user_link(feed_uid)
    get_pic(uid)
    body = post["body"]
    post_url = post["short_url"]
    title = post["title"]
    url = post["url"]
    description = post["description"]
    content = "<hr><img src=\"#{@avatar}\"/><a href=\"#{blog_link[1]}>#{blog_link[0]}</a>
                    <h4><a href=\"#{post_url}\">#{title}</a></h4><a href=#{url}>Link</a><p>#{description}</p><hr>"
      return content
  end

  def format_video_post(feed_uid, post)
    blog_link = get_user_link(feed_uid)
    get_pic(uid)
    body = post["body"]
    post_url = post["short_url"]
    title = post["title"]
    source_title = post["source_title"]
    source_url = post["source_url"]
    caption = post["caption"]
    player = post["player"][1]["embed_code"]
    content = "<hr><img src=\"#{@avatar}\"/><a href=\"#{blog_link[1]}>#{blog_link[0]}</a>
                    <h4><a href=\"#{post_url}\">#{source_title}</a></h4>#{caption} #{player}<hr>"
      return content
  end

  def format_audio_post(feed_uid, post)
    blog_link = get_user_link(feed_uid)
    get_pic(uid)
    body = post["body"]
    post_url = post["short_url"]
    source_title = post["source_title"]
    caption = post["caption"]
    player = post["player"]
    content = "<hr><img src=\"#{@avatar}\"/><a href=\"#{blog_link[1]}>#{blog_link[0]}</a>
                    <a href=\"#{post_url}\">#{source_title}</a></h4>#{caption} #{player}<hr>"
      return content
  end

  def format_answer_post(feed_uid, post)
    blog_link = get_user_link(feed_uid)
    get_pic(uid)
    question = post["question"]
    answer = post["answer"]
    post_url = post["short_url"]
    title = post["title"]
    content = "<hr><img src=\"#{@avatar}\"/><a href=\"#{blog_link[1]}>#{blog_link[0]}</a>
                    <h4><a href=\"#{post_url}\">#{question}</a></h4>#{answer}<hr>"
    return content
  end

  def format_chat_post(feed_uid, post)
    blog_link = get_user_link(feed_uid)
    get_pic(uid)
    body = post["body"]
    post_url = post["short_url"]
    title = post["title"]
    content = "<hr><img src=\"#{@avatar}\"/><a href=\"#{blog_link[1]}>#{blog_link[0]}</a>
                    <h4><a href=\"#{post_url}\">#{title}</a></h4><p>#{body}</p><hr>"
   return content
  end
end
