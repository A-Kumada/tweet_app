class Tweet < ApplicationRecord
  has_many:likes, dependent: :destroy
  has_many:comments, dependent: :destroy
  has_many :replies, class_name: "Commen", foreign_key: :reply_comment, dependent: :destroy
  belongs_to:user

  has_one_attached :image

end
