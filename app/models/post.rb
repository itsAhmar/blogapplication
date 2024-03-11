class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, as: :likeable , dependent: :destroy

  validates :title, :description, presence: true

  has_one_attached :image
  validates :image, presence: true
end
