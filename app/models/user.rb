class User < ApplicationRecord

  validates :email, uniqueness: true
  validates :username, uniqueness: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :following_relationships, foreign_key: 'follower_id', class_name: 'Relationship', dependent: :destroy
  has_many :followings, through: :following_relationships, source: :following

  has_many :follower_relationships, foreign_key: 'following_id', class_name: 'Relationship', dependent: :destroy
  has_many :followers, through: :follower_relationships, source: :follower

  has_one :profile, dependent: :destroy
  has_one_attached :userimage

  def prepare_profile
    profile || build_profile
  end

  def avatar_image
    if profile&.userimage&.attached?
      profile.userimage
    else
      'f_f_object_105_s512_f_object_105_1bg.png'
    end
  end

  def follow!(user)
    user_id = get_user_id(user)
    following_relationships.create!(following_id: user_id)
  end

  def has_followed?(user)
    following_relationships.exists?(following_id: user.id)
  end

  def unfollow!(user)
    user_id = get_user_id(user)

    relation = following_relationships.find_by!(following_id: user_id)
    relation.destroy!
  end

  def hasliked?(post)
    likes.exists?(post_id: post.id)
  end

  def following_count
    followings.count
  end

  def follower_count
    followers.count
  end

  private
  def get_user_id(user)
    if user.is_a?(User)
      user.id
    else
      user
    end
  end

end


