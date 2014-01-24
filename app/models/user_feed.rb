class UserFeed < ActiveRecord::Base
  belongs_to :feed
  belongs_to :user

  def self.create_relationship(feed, user)
    self.create!(
      feed_id: feed.id,
      user_id: user.id,
    )
  end

  def self.find_relationship(feed, user)
    @relationship = UserFeed.find_by_feed_and_user(feed, user)
  end
end
