module LikesHelper
  def detect_user_liked(likeable)
    likeable.likes.detect { |like| like.user_id == current_user.id }
  end

  def display_like_count(likeable)
    like_count = likeable.likes.count
    like_count == 0 ? '0 Like' : "#{like_count} #{'Like'.pluralize(like_count)}"
  end
end
