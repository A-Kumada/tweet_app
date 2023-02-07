class Public::UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
  end
  
  def user_params
    params.require(:user).permit(:name, :profile, :birthday, :email, :is_active)
  end
end
