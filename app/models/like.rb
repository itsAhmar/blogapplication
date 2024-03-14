class Like < ApplicationRecord
  validates :user_id, uniqueness: { scope: %i[likeable_id likeable_type] }

  belongs_to :user
  belongs_to :likeable, polymorphic: true
  #scope :for_likeable, ->(likeable) { where(user: current_user, likeable: likeable).first }
  
end
