class Public::UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @tweets = Tweet.all
  end

  def user_params
    params.require(:user).permit(:name, :profile, :birthday, :email, :is_active, :image)
  end
end
