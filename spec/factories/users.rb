# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    username { Faker::Name.middle_name }
    password { Faker::Internet.password }
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'img.jpg'), 'image/jpeg') }

    trait :without_image do
      # No image
    end
  end
end
