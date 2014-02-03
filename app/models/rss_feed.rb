class RSSFeed < Feed

  def find_or_create_post(feed_uid, post)
    datetime = post.published
    content = post.content
    @feed = Feed.find_by(uid: feed_uid)
    Post.find_by(content: content) || Post.create(
      content: content,
      feed_id: @feed.id,
      datetime: datetime,
      feed_uid: feed_uid)
  end

  def get_pic(url)
    '/assets/rssImage.jpg'
  end

  def get_user_link(url)
    @find_rss = Feedzirra::Feed.fetch_and_parse(url)
    [@find_rss.title, @find_rss.url]
  end

  def get_posts(url)
    @find_rss = Feedzirra::Feed.fetch_and_parse(url)
    @find_feed = Feed.find_by(uid: url)
    @find_rss.entries.each do |posts|
      new_post = Post.create(
        feed_id: @find_feed.id, 
        datetime: posts.published, 
        feed_uid: @find_feed.uid)

      if posts.summary
        new_post[:content] = "<div class='rss-content'><img src='/assets/rssImage.jpg'/> <h3>#{@find_rss.title}</h3> #{posts.summary} <i><a href='#{posts.url}'>#{posts.title}</a></i> </div> "
      else
        new_post[:content] = "<div class='rss-content'>'><img src='/assets/rssImage.jpg'/> <h3>#{@find_rss.title}</h3> <a href='#{posts.url}'>#{posts.title}</a> </div><br>"
      end    
      new_post.save
    end
  end
end