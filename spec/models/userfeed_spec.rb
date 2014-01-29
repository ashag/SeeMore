require 'spec_helper'

describe UserFeed do

  describe 'validations' do 
    it 'will create relationship between user and feed' do 
      asha = User.new(username: 'asha', email: 'blah@gmail.com')
      feed = Feed.new(uid: 'blah', type: 'RSSFeed') 
      ashafeed = UserFeed.create(user_id: asha.id, feed_id: feed.id) 
      expect(ashafeed).to be_valid
    end
  end
end