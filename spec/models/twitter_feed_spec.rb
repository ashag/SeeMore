require 'spec_helper'

describe TwitterFeed do 
  let(:twitter_feed) { create(:twitter_feed) }
  let(:uid) { 2305620871 }
  describe 'client' do
    it 'creates a client' do
      expect(TwitterFeed.client.class).to be(Twitter::REST::Client)
    end

    # not sure how to test the API here, but it appears to pass when it is able
    # to call and access the method. As a control, I tried both TwitterFeed.client.potato
    # and TwitterFeed.client.user(potato), both of which failed.
    it 'can use the Twitter API' do
      expect(TwitterFeed.client.user(uid))
    end
  end

  describe 'helper methods' do
    describe 'get_user_link' do
      it 'returns a valid array' do 
        expect(twitter_feed.get_user_link(uid)).to eq(["feed_hunter", "https://www.twitter.com/feed_hunter"])
      end
    end

    describe 'get_pic' do
      it 'retuns a valid image url' do
        expect(twitter_feed.get_pic(uid).class).to eq(Addressable::URI)
      end
    end

    describe 'get_posts' do 
      it 'creates an array' do
        expect(twitter_feed.get_posts(uid).class).to eq(Array)
      end
      it 'returns an array of tweets' do
        expect(twitter_feed.get_posts(uid)[0].class).to eq(Twitter::Tweet)
      end
    end
  end

  describe 'find_or_create_post' do 
    let(:example_post) { twitter_feed.get_posts(uid)[0] }
    it 'returns a Post object' do
      expect(twitter_feed.find_or_create_post(uid, example_post).class).to eq(Post)
    end

    it 'returns a Post object even if the Post object already exists' do 
      twitter_feed.find_or_create_post(uid, example_post)
      expect(twitter_feed.find_or_create_post(uid, example_post).class).to eq(Post)
    end
  end
end