FactoryGirl.define do
  factory :twitter_feed, class: TwitterFeed do
    uid "2305620871"
    type "TwitterFeed"
    id 1
  end

  factory :post, class: Post do
    feed_id 1
    content "This post is a great success!"
    date "2014-1-26"
    feed_uid "2305620871"
  end
  
  factory :tumblr_feed, class: TumblrFeed do 
    uid "llenees"
    type "TumblrFeed"
    id 1
  end
end