# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'img.jpg'), 'image/jpeg') }
  end
end
