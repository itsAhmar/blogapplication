class RemoveFkFromLikesToPosts < ActiveRecord::Migration[7.1]
  def change
    remove_foreign_key :likes, :posts
  end
end
 