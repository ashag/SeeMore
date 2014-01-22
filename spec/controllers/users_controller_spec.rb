require 'spec_helper'

describe UsersController  do

  describe "GETnew" do
    it "returns successful" do
      get :new
      expect(response).to be_successful
    end
  end

  describe "POSTcreate" do
    it "redirects on creation" do 
      # new_user = User.create(username: "newuser", email: "123@123.com", provider: "a thing", uid: "uid sample" )
      post :create, user: {username: "newuser", email: "123@123.com", provider: "a thing", uid: "uid sample" }
      expect(response.code).to redirect_to show_user(assigns(:user).id)
      
    end 
  end

end