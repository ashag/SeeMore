describe SessionsController do
  describe "GET 'create'" do
    context "when using developer authorization" do
      context "is successful" do
        before { request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:developer] }

        it "redirects to home page" do
          get :create, provider: :developer
          expect(response).to redirect_to root_path
        end

        it "creates a user" do
          expect { get :create, provider: :developer }.to change(User, :count).by(1)
        end

        it "assigns the @user var" do
          get :create, provider: :developer
          expect(assigns(:user)).to be_an_instance_of User
        end

        it "assigns the session[:user_id]" do
          get :create, provider: :developer
          expect(session[:user_id]).to eq assigns(:user).id
        end

      end

      context "when the user has already signed up" do
        before { request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:developer] }
        let!(:user) { User.find_or_create_from_omniauth(OmniAuth.config.mock_auth[:developer]) }

        it "doesn't create another user" do
          expect { get :create, provider: :developer }.to_not change(User, :count).by(1)
        end

        it "assigns the session[:user_id]" do
          get :create, provider: :developer
          expect(session[:user_id]).to eq user.id
        end
      end
      
    end
  end
end