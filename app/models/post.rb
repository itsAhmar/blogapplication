# frozen_string_literal: true

# Represents a post in the application
class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
  validates :title, :description, presence: true
  has_one_attached :image
  validates :image, presence: true

  after_create_commit { enqueue_post_email('create', title, user.email) }
  after_update { enqueue_post_email('update', title, user.email) }
  after_destroy_commit { enqueue_post_email('destroy', title, user.email) }

  def enqueue_post_email(action, title, user_email)
    SendEmailJob.perform_async(action, title, user_email)
  end
end
