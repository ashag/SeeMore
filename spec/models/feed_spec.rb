require 'spec_helper'

describe Feed do
  let!(:feed) {Feed.new(uid: '12345', type: 'TwitterFeed')}
  describe 'validations' do 
    it 'is valid' do 
      expect(feed).to be_valid
    end

    it 'requires a uid' do
      feed.username = nil
      expect(feed).to be_invalid
    end

    it 'requires a type' do
      
    end

    it 'requires a unique uid' do 

    end
  end
end
