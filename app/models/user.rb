class User < ActiveRecord::Base

	validates		:username, :provider, :email, :uid, presence: true
	validates 	:username, :email, uniqueness: true


end
