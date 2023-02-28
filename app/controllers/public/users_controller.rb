class Public::UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @tweets = current_user.tweets.order(created_at: :desc)
  end

  def edit
    @user = User.find(params[:id])
    unless
      @user == current_user
      redirect_to root_path
    end
  end

  def update
    @user = User.find(params[:id])
     #binding.pry
     respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
        format.js { @status = "success"}
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
        format.js { @status = "fail" }
      end
     end
    #if @user.update(user_params)
      #flash[:success] = '変更しました'
      #redirect_to user_path(@user)
    #else
      #@user.update(is_active: "false")
      #render:edit
    #end
  end

  def unsubscribe
    @user = User.find(current_user.id)
  end

  def withdraw
    @user = User.find(current_user.id)
    @user.update(is_active: "false")
    reset_session
    redirect_to root_path
  end

  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.page(params[:page])
    render 'public/users/show_follow', status: :unprocessable_entity
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.page(params[:page])
    render 'show_follow', status: :unprocessable_entity
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile, :birthday, :email, :is_active, :image)
  end

  def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url, status: :see_other
      end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url, status: :see_other) unless current_user?(@user)
  end

end
