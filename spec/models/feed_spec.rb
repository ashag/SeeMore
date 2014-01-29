require 'spec_helper'

describe Feed do

  describe 'validations' do 
    it 'is valid' do 
      expect(create(:feed)).to be_valid
    end

    it 'requires a uid' do
      expect(build(:feed, uid: nil)).to be_invalid
    end

    it 'requires a type' do
      expect(build(:feed, type: nil)).to be_invalid
    end

    it 'requires a unique uid' do 
      feed = create(:feed, uid: '123')
      expect(build(:feed, uid: '123')).to be_invalid
    end
  end
end
