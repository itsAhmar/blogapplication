# frozen_string_literal: true

# Represents a post in the application
class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
  validates :title, :description, presence: true
  has_one_attached :image
  validates :image, presence: true

  after_create_commit :post_creation_email
  after_destroy_commit :post_deletion_email
  before_destroy :capture_post_info

  def post_creation_email
    PostMailer.create_post(self).deliver_later
  end

  # def post_deletion_email
  #   title = self.title
  #   user_email = self.user.email
  #   PostMailer.delete_post(title,user_email).deliver_later
  # end

  def capture_post_info
    @post = self
  end

  def post_deletion_email
    PostMailer.delete_post(@post.title, @post.user.email).deliver_later
  end

end
