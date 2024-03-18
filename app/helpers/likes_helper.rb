# frozen_string_literal: true

# Helper methods for managing likes
module LikesHelper
  def user_liked?(likeable)
    likeable.likes.detect { |like| like.user_id == current_user.id }
  end

  def likes_count(likeable)
    like_count = likeable.likes.count
    like_count.zero? ? '0 Like' : "#{like_count} #{'Like'.pluralize(like_count)}"
  end
end
