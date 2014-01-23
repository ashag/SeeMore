Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer
  provider :tumblr, ENV["TUMBLR_CLIENT_ID"], ENV["TUMBLR_CLIENT_SECRET"]
end