require 'spec_helper'

describe UserFeed do
  let!(:asha) { User.create(username: 'asha', email: 'blah@gmail.com') }
  let!(:feed) { Feed.create(uid: 'blah', type: 'RSSFeed') }

  describe 'create relationship method' do 
    it 'will create relationship between user and feed' do 
      ashafeed = UserFeed.create_relationship(asha, feed) 
      expect(ashafeed).to be_valid
    end
  end

  describe 'following method' do
    let!(:ashafeed) { UserFeed.create_relationship(feed, asha) }
    # let!(:new_user) { User.create(username: 'person', email: 'person@gmail.com') }

    it 'will return true' do 
      find = UserFeed.following?(asha.id, feed.uid)
      expect(find).to be_true
    end

    # it 'will return false' do
    #   find = UserFeed.following?(new_user.id, feed.uid)
    #   expect(find).to be_false
    # end
  end
end