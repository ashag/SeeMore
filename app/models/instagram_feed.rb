class InstagramFeed < Feed 

  def find_or_create_post(feed_uid, post)
    @feed = Feed.find_by(uid: feed_uid)
    content = assign_content(post)
    date = DateTime.strptime("#{post.created_time}", '%s')
    Post.find_by(content: content) || Post.create(
      content: content,
      feed_id: @feed.id,
      datetime: date,
      feed_uid: feed_uid)
  end

  def get_posts(user_id)
    @recent_media = Instagram.user_recent_media(user_id.to_i)
    posts = []
    @recent_media.map do |post|
      posts << post
    end
    posts
  end

  def get_pic(post)    
    post["user"]["profile_picture"]
  end

  def check_media_type(post)
    type = post["type"]

    case type
    when "image"
      media = post["images"]["low_resolution"]["url"]
    when "video"
      media = post["videos"]["low_resolution"]["url"]
    end
    return media
  end

  def get_caption(post)
    check_caption = post["caption"]["text"]
  end

  def get_username(post)
    post["user"]["username"]
  end

  def assign_content(post)
    picture = get_pic(post)
    media = check_media_type(post)
    username = get_username(post) 
    caption = get_caption(post)
    # if get_caption(post).nil? { |c| c.reject } 

    # if find_caption.nil?
    #   @caption = puts " "
    # else
    #   @caption = find_caption
    # end 

    content = " <table><tr><strong>#{username}</strong> <img src=\"#{picture}\"/></tr><br> <tr><img src=\"#{media}\"/></tr><br> <tr>#{@caption} </tr></table>"
    return content
  end


  def self.client
    Instagram.configure do |config|
      config.client_id = ENV["INSTAGRAM_CLIENT_KEY"]
      config.client_secret = ENV["INSTAGRAM_CLIENT_SECRET"]
      # config.access_token = ENV["INSTAGRAM_ACCESS_TOKEN"]
    end
  end

end