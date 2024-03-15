# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'open-uri'
50.times do
  post = Post.new(
    title: Faker::Lorem.sentence,
    description: Faker::Lorem.paragraphs(number: 3).join("\n"),
    user_id: 1
  )
  file = URI.open(Faker::Avatar.image)
  post.image.attach(io: file, filename: "image_#{rand(1000)}.jpg", content_type: 'image/jpg')
  post.save
end
