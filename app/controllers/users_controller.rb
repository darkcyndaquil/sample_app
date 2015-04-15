class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user]) #changed due to errors look at book before continuing
    if @user.save
	  sign_in @user
	  flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end

 # private

    #def user_params
     # params.require(:user).permit(:name, :email, :password, :password_confirmation)
    #end
  
end
