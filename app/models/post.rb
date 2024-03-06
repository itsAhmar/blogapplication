class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :title, :description, presence: true

  has_one_attached :image
  validates :image, presence: true
end
