class User < ActiveRecord::Base

  validates :email, :username, :uid, :provider, presence: true

  has_many :user_feeds
  has_many :feeds, through: :user_feeds

  def self.find_or_create_from_omniauth(auth_hash)
    User.find_by(uid: auth_hash["uid"]) || create_from_omniauth(auth_hash)
  end

  def self.create_from_omniauth(auth_hash)
    self.create!(
      uid:      auth_hash["uid"],
      provider: auth_hash["provider"],
      email:    auth_hash["info"]["email"],
      avatar_url: auth_hash["info"]["image"],
      username: auth_hash["info"]["name"]
    )
  rescue ActiveRecord::RecordInvalid
    nil
  end
end
