require 'spec_helper'

describe User do
	let!(:user) {User.new(username: 'firstuser', uid: '12345', provider: 'twitter', email: 'a@g.com')}
  describe 'validations' do
  	it 'is valid' do
  		expect(user).to be_valid
  	end

  	it ' does not require an email' do
  		user.email = nil
  		expect(user).to be_valid
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
