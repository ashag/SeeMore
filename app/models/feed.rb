class Feed < ActiveRecord::Base
  has_many :user_feeds
  has_many :users, through: :user_feeds
  validates :uid, uniqueness: true

  def self.exist?(uid)
    Feed.find_by(uid: uid.to_s)
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

  def self.sort_feed(user_id)
    feed_posts = []
    current_user = User.find(user_id)
    current_user.feeds.each do |feed|
      Post.where(feed_id: feed.id).each do |post|
        feed_posts << post
      end
    end
    feed_posts.sort_by {|post| post.date }.reverse
  end

end
