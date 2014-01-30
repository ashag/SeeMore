class User < ActiveRecord::Base

  validates :username, :uid, :provider, presence: true

  has_many :user_feeds
  has_many :feeds, through: :user_feeds

  def self.find_or_create_from_omniauth(auth_hash)
    user = User.find_by(uid: auth_hash["uid"]) || User.create_from_omniauth(auth_hash)
    user.check_twitter_credentials(auth_hash)
    return user
  end

  def check_twitter_credentials(auth_hash)
    if self.secret != auth_hash[:credentials][:secret] || self.token != auth_hash[:credentials][:token]
      update(secret: auth_hash[:credentials][:secret], 
             token:  auth_hash[:credentials][:token])
    end
  end

  def self.create_from_omniauth(auth_hash)
    User.create!(
      uid:        auth_hash["uid"],
      provider:   auth_hash["provider"],
      avatar_url: auth_hash["info"]["image"],
      username:   auth_hash["info"]["name"],
      secret:     auth_hash[:credentials][:secret],
      token:      auth_hash[:credentials][:token]
    )
  rescue ActiveRecord::RecordInvalid
    nil
  end
end
