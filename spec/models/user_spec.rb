require 'spec_helper'

describe User do
	let!(:user) {User.new(username: 'firstuser', provider: 'developer', email: 'a@g.com')}
  describe 'validations' do 
  	it 'is valid' do 
  		expect(user).to be_valid
  	end

  	it 'requires an email' do
  		new_user = User.new(username: 'something', provider: 'developer', email: nil)
  		expect(new_user).to be_invalid
  	end

  	it 'requires a username' do 
  		user.username = nil
  		expect(user).to be_invalid
  	end

  	it 'requires a uid' do 
  		user.uid = nil
  		expect(user).to be_invalid
  	end

  	it 'requires a provider' do 
  		user.provider = nil
  		expect(user).to be_invalid
  	end
  end
end
