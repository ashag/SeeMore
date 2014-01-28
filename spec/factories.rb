FactoryGirl.define do
  factory :twitter_feed do
    uid "2305620871"
    type "TwitterFeed"
    id 1
  end
  factory :post do
    feed_id 1
    content "This post is a great success!"
    date "2014-1-26"
    feed_uid "2305620871"
  end
end