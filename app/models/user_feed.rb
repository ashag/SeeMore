class UserFeed < ActiveRecord::Base
  belongs_to :feed
  belongs_to :user

  def self.following?(user_id, result_id)
    feed = Feed.find_by(uid: result_id.to_s)
    return false unless feed

    relationship = UserFeed.where("user_id = ? AND feed_id = ?", user_id, feed.id)
    return false if relationship.nil?

    return true
  end

  def self.create_relationship(feed, user)
    self.create!(
      feed_id: feed.id,
      user_id: user.id,
    )
  end

  def self.find_or_create(feed, user)
    if UserFeed.where(feed_id: feed.id, user_id: user.id).empty?
      UserFeed.create_relationship(feed, user)
    end
  end
end