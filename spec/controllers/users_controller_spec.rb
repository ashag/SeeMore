require 'spec_helper'

describe UsersController  do


  describe "POSTcreate" do
    it "redirects on creation" do 
      # new_user = User.create(username: "newuser", email: "123@123.com", provider: "a thing", uid: "uid sample" )
      post :create, user: {username: "newuser", email: "123@123.com", provider: "a thing", uid: "uid sample" }
      expect(response.code).to redirect_to root_path
    end 
  end

  describe "initialize_from_omniauth" do
    let(:user) { User.find_or_create_from_omniauth(OmniAuth.config.mock_auth[:twitter]) }

    it "creates a valid user" do
      expect(user).to be_valid
    end

    context "when it's invalid" do
      it "returns nil" do
        user = User.find_or_create_from_omniauth({"uid" => "123", "info" => {}})
        expect(user).to be_nil
      end
    end
  end
end
