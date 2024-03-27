# frozen_string_literal: true

# Represents a post in the application
class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
  validates :title, :description, presence: true
  has_one_attached :image
  validates :image, presence: true

  before_save :capture_post_info
  after_update_commit { enqueue_post_email('update') }
  after_create_commit { enqueue_post_email('create') }
  after_destroy_commit { enqueue_post_email('destroy') if capture_post_info }

  def capture_post_info
    @title = title
    @user_email = user.email
  end

  def enqueue_post_email(action)
    SendEmailJob.perform_async(action, @title, @user_email)
  end
end
