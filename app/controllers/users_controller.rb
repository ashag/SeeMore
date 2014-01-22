class UsersController < ApplicationController
before_action :set_user, only: [:show, :edit, :update, :destroy]

# do we need any of these for bronze level?
  def show
  end

  def edit
  end

  def update
  end

  def destroy
    redirect_to :goodbye
  end

# do we need this as a method? ask about refactoring/route
  def goodbye
  end


  private

  def set_user
    @user = User.find(params[:id])
  end

  def set_user_params
    params.require(:user).permit(:username, :email, :provider, :uid, :avatar_url, :id)
  end

end
