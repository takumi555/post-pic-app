class Post < ApplicationRecord

  validates :pictures, presence: true
  validates :content, presence: true

  has_many_attached :pictures

  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
end


def like_count
  likes.count
end