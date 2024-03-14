module LikesHelper
  def display_like_count(likeable)
    like_count = likeable.likes.size
    like_count == 0 ? '0 Like' : "#{like_count} #{'Like'.pluralize(like_count)}"
  end
end
