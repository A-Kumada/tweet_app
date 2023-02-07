class Public::TweetsController < ApplicationController

  def index
    @tweet = current_user.tweets.build
    @tweets = current_user.tweets.all.order(created_at: :desc)
  end

  def create
    @tweet = current_user.tweets.build(tweet_params)
    if @tweet.save
      redirect_to tweets_path
    else
      redirect_to tweets_path,notice: "失敗してるよ"
    end
  end

  def show
  end

  def edit
  end

  def destroy
  end

   private

  def tweet_params
    params.require(:tweet).permit(:user_id, :content)
  end

end
