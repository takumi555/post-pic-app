class User < ApplicationRecord

  validates :email, uniqueness: true
  validates :username, uniqueness: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar

  
  mount_uploader :avatar, AvatarUploader
  

  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :following_relationships, foreign_key: 'follower_id', class_name: 'Relationship', dependent: :destroy
  has_many :followings, through: :following_relationships, source: :following

  has_many :follower_relationships, foreign_key: 'following_id', class_name: 'Relationship', dependent: :destroy
  has_many :followers, through: :follower_relationships, source: :follower

  def follow!(user)
    following_relationships.create!(following_id: user.id)
  end

  def unfollow!(user)
    relation = following_relationships.find_by!(following_id: user.id)
    relation.destroy!
  end

  def hasliked?(post)
    likes.exists?(post_id: post.id)
  end

end
