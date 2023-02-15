class Public::TweetsController < ApplicationController
before_action :authenticate_user!

  def index
    @tweet = Tweet.new
    @tweets = Tweet.page(params[:page]).order(created_at: :desc)
    @user = @tweet.user
    respond_to do |format|
    format.html
    format.js # js形式で送信された場合はこちらが適応され、js.erbを探す
    end
  end

  def create
    @tweet = current_user.tweets.build(tweet_params)
    if @tweet.save
      redirect_to tweets_path
    else
      @tweets = Tweet.all
      redirect_to tweets_path,notice: "失敗してるよ"
    end
  end

  def show
    @tweet = Tweet.find(params[:id])
    @user = @tweet.user
    @comment = Comment.new
    @comments = Comment.all.order(created_at: :desc)
  end

  def edit
  end

  def destroy
    @tweet = Tweet.find(params[:id])
    @tweet.user_id = current_user.id
    @tweet.destroy
    redirect_to tweets_path
  end

   private

  def tweet_params
    params.require(:tweet).permit(:user_id, :content, :image)
  end

end
