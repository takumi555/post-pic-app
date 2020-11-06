class Post < ApplicationRecord

  validates :pictures, presence: true
  validates :content, presence: true

  has_many_attached :pictures

  belongs_to :user 
end
