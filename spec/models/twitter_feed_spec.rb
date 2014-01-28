require 'spec_helper'

describe TwitterFeed do 
  describe 'client' do
    it 'creates a client' do
      expect(TwitterFeed.client.class).to be(Twitter::REST::Client)
    end

    # not sure how to test the API here, but it appears to pass when it is able
    # to call and access the method. As a control, I tried both TwitterFeed.client.potato
    # and TwitterFeed.client.user(potato), both of which failed.
    it 'can use the Twitter API' do
      expect(TwitterFeed.client.user(2305620871))
    end
  end

  describe 'helper methods' do
    describe 'get_user_link' do
      it 'returns a valid array' do 
        twitter_feed = create(:twitter_feed)
        expect(twitter_feed.get_user_link(2305620871)).to eq()
    end
  end
end