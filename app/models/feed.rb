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

end
