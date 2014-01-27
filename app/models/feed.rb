class Feed < ActiveRecord::Base
  has_many :user_feeds
  has_many :users, through: :user_feeds
  validates :uid, uniqueness: true

  def self.exist?(uid)
    Feed.find_by(uid: uid)
  end


  def self.find_or_create(params)
    Feed.find_by(uid: params[:uid]) || create(params)
  end

  def self.create(params)
    self.create!(
      uid:  params[:uid],
      type: params[:type]
    )
  rescue ActiveRecord::RecordInvalid
    nil
  end

  def self.sort_feed
    
  end


  # Not sure what the default will be; this method will be specified in the
  # inherited tables to show an avatar, user pic, etc.
  def self.get_pic(pic)
  end


  # This will return an array to build a link to the user. It will be used in the feed so you can
  # click on a user to go to their external page. The format should be [name, html_link_info]
  def self.get_user_link(link)
  end

  # This will return the content of a post (so a tweet, a tumblr post, etc.)
  def self.get_content(content)
  end
end
