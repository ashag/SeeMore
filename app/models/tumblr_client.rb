class TumblrClient

  def self.new_client
    Tumblr.configure do |config|
      config.consumer_key       = ENV["TUMBLR_CLIENT_ID"]
      config.consumer_secret    = ENV["TUMBLR_CLIENT_SECRET"]
      config.oauth_token        = ENV["TUMBLR_ACCESS_TOKEN"]
      config.oauth_token_secret = ENV["TUMBLR_ACCESS_TOKEN_SECRET"]
    end

    return Tumblr::Client.new
  end
end
