require 'spec_helper'

describe TumblrFeed do 
  let(:tumblr_feed) { create(:tumblr_feed) }
  let(:uid) { 'llenees' }

  describe 'helper methods' do
    describe 'get_user_link' do
      it 'returns the expected array' do 
        expect(tumblr_feed.get_user_link(uid)).to eq(['llenees', 'http://llenees.tumblr.com/'])
      end
    end

    describe 'get_pic' do 
      it 'returns a valid link' do 
        expect(tumblr_feed.get_pic(uid)).to eq('http://assets.tumblr.com/images/default_avatar/octahedron_closed_64.png')
      end
    end

    describe 'get_blog' do 
      it 'returns a hash' do
        expect(tumblr_feed.get_blog(uid).class).to eq(Hash)
      end
      # I know this test could be read as testing the API, but I just wanted to
      # make sure that the hash we were receiving included the correct information
      it 'includes title, name, posts, url, updated, description, ask, ask_anon, is_nsfw, share_likes, and likes' do
        expect(tumblr_feed.get_blog(uid)['blog'].keys).to include('title', 'name', 'posts', 'url', 'updated', 'description', 'ask', 'ask_anon', 'is_nsfw', 'share_likes', 'likes')
      end
    end

    describe 'get_posts' do 
      it 'returns an array' do
        expect(tumblr_feed.get_posts(uid).class).to eq(Array)
      end

      it 'returns an array of blog hashes' do 
        expect(tumblr_feed.get_posts(uid)[0].class).to eq(Hash)
      end 
    end
  end
  describe 'find_or_create_post' do 
    let(:example_post) { tumblr_feed.get_posts(uid)[0] }
    it 'returns a Post object' do
      expect(tumblr_feed.find_or_create_post(uid, example_post).class).to eq(Post)
    end

    it 'returns a Post object even if the Post object already exists' do 
      tumblr_feed.find_or_create_post(uid, example_post)
      expect(tumblr_feed.find_or_create_post(uid, example_post).class).to eq(Post)
    end
  end
end