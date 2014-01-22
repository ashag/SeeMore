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
      post :create, user: {username: "newuser", email: "123@123.com", provider: "a thing", uid: "uid sample" }
      expect(response.code).to eq '304'
    end 
  end


  
end