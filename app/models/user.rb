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


  def hasliked?(post)
    likes.exists?(post_id: post.id)
  end

end
