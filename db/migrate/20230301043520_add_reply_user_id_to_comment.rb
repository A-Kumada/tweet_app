class AddReplyUserIdToComment < ActiveRecord::Migration[6.1]
  def change
    add_column :comments, :reply_comment, :int
  end
end
