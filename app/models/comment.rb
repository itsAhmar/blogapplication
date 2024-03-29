# frozen_string_literal: true

# Represents a comment on a post
class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  belongs_to :parent, class_name: 'Comment', optional: true
  has_many :comments, foreign_key: :parent_id, dependent: :destroy
  has_many :likes, as: :likeable
  validates :content, presence: true
end
