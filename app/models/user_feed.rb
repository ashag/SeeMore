class UserFeed < ActiveRecord::Base
  belongs_to :feed
  belongs_to :user

  def self.following?(user_id, result_id)
    feed = Feed.find_by(uid: result_id)
    return false unless feed
    UserFeed.where("user_id = ? AND feed_id = ?", user_id, feed.id)
  end

  def self.create_relationship(feed, user)
    self.create!(
      feed_id: feed.id,
      user_id: user.id,
    )
  end
end
