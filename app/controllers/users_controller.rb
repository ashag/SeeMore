class UsersController < ApplicationController
before_action :set_user, only: [:show, :edit, :update, :destroy]



# for potential future use in order to delete a user's profile
  # def destroy
  #   redirect_to :goodbye
  # end

  # def goodbye
  # end

end
