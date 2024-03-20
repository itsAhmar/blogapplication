FactoryBot.define do
  factory :post do
    title { Faker::Lorem.sentence }
    description {Faker::Lorem.paragraph}
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'img.jpg'), 'image/jpeg') }
    user
  end
end
