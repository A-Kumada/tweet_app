class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true
  VALID_PASSWORD_REGEX = /\A[a-z0-9]+\z/i
  validates :password ,presence: true, unless: :uid?, on: :create, 
                      length: { minimum: 6 }, format: { with: VALID_PASSWORD_REGEX }
  validates :profile, length: { maximum: 255 }
  validates :birthday, presence: true

  has_one_attached :image

  has_many :tweets, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship",
                                  foreign_key: "follower_id",
                                  dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship",
                                   foreign_key: "followed_id",
                                   dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  def liked_by?(tweet_id)
    likes.where(tweet_id: tweet_id).exists?
  end

  def feed
    part_of_feed = "relationships.follower_id = :id or tweets.user_id = :id"
    Tweet.left_outer_joins(user: :followers)
             .where(part_of_feed, { id: id }).distinct
  end

  def follow(other_user)
    following << other_user unless self == other_user
  end

  def unfollow(other_user)
    following.delete(other_user)
  end

  def following?(other_user)
    following.include?(other_user)
  end

  def feed
    part_of_feed = "relationships.follower_id = :id or tweets.user_id = :id"
    Tweet.left_outer_joins(user: :followers)
             .where(part_of_feed, { id: id }).distinct
             .includes(:user, image_attachment: :blob)
  end

  private

end
