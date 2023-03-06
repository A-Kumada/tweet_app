class Comment < ApplicationRecord
  belongs_to:user
  belongs_to:tweet
  validates :tweet_comment,presence: true, length: { maximum: 255 }

end
