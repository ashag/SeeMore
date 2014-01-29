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
  factor :user_feed do
    user_id 1
    feed_id 1
  end
  factory :user do
    id 1
    username 'Audrey Carlsen'
    uid '478104543'
    provider 'twitter'
  end
  factory :post1 do
    feed_id 1
    date '2014-01-23'
  end
  factory :post2 do
    feed_id 1
    date '2014-01-24'
  end
end