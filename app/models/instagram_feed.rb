require 'date'

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
    @recent_media.each do |post|
      posts << post
    end
    posts
  end

  def get_profile_picture(post)    
    post["profile_picture"]
  end

  def check_media_type(post)
    # user_media = Instagram.user_recent_media(user_id)
    type = post["type"]

    case type
    when "image"
      @media = post["images"]["standard_resolution"]["url"]
    when "video"
      @media = post["videos"]["standard_resolution"]["url"]
    end
    return @media
  end

  def get_caption(post)
    post["caption"]["text"]
  end

  def assign_content(post)
    picture = get_profile_picture(post)
    media = check_media_type(post)
    caption = get_caption(post)

    content = " <img src=\"#{picture}\" /> <img src=\"#{media}\"/> #{caption} "
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