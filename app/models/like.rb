# frozen_string_literal: true

# Represents a like given to a resource
class Like < ApplicationRecord
  validates :user_id, uniqueness: { scope: %i[likeable_id likeable_type] }
  belongs_to :user
  belongs_to :likeable, polymorphic: true
end
