class User < ActiveRecord::Base

	validates			:username, :email, :uid, presence: true
	validates 			:username, :email, uniqueness: true


end
