class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      # Handle successful submit
    else 
      render 'new'
    end
  end

  private 

    def user_params
      params.require(:user).permit(:email, 
                                   :name, 
                                   :password, 
                                   :password_confirmation)
    end
end
