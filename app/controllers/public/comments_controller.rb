class Public::CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @tweet = Tweet.find(params[:tweet_id])
    #binding.pry
    @comment = current_user.comments.new(comment_params)
    @comment.tweet_id = @tweet.id
    if @comment.save
      redirect_to tweet_path(@tweet)
    else
      redirect_to tweets_path
    end
  end

  def destroy
    Comment.find(params[:id]).destroy
    redirect_to tweet_path(params[:tweet_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:tweet_comment,:reply_comment).merge(user_id: current_user.id, tweet_id: params[:product_id])
  end
end
