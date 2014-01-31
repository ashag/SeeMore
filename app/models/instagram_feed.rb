class InstagramFeed < Feed 

  def get_id(uid)
    @instagram.id(uid)
  end

  def profile_photo

  end




  def self.client
    @client = Instagram.configure do |config|
      config.client_id = ENV["INSTAGRAM_CLIENT_KEY"]
      config.client_secret = ENV["INSTAGRAM_CLIENT_SECRET"]
      # config.access_token = ENV["INSTAGRAM_ACCESS_TOKEN"]
    end
  end

end