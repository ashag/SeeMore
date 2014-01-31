require 'spec_helper'

describe Feed do

  describe 'validations' do 
    it 'is valid' do 
      expect(build(:twitter_feed)).to be_valid
    end

    it 'requires a uid' do
      expect(build(:twitter_feed, uid: nil)).to be_invalid
    end

    it 'requires a type' do
      expect(build(:twitter_feed, type: nil)).to be_invalid
    end

    it 'requires a unique uid' do 
      feed = create(:twitter_feed, uid: '123')
      expect(build(:twitter_feed, uid: '123')).to be_invalid
    end
  end

  describe 'sort_feed' do
    let!(:twitter_feed) { create(:twitter_feed) }
    let!(:user) { create(:user) }
    let!(:user_feed) { create(:user_feed) }
    let!(:post1) { create(:post1) }
    let!(:post2) { create(:post2) }

    it 'returns an array' do
      expect(Feed.sort_feed(1).class).to eq(Array)
    end

    it 'returns an array of posts' do
      expect(Feed.sort_feed(1)[0].class).to eq(Post)
    end

    it 'posts are in chronological order' do
      expect(Feed.sort_feed(1)[0].datetime).to eq(DateTime.parse('2014-01-24'))
      expect(Feed.sort_feed(1)[1].datetime).to eq(DateTime.parse('2014-01-23'))
    end
  end
end
