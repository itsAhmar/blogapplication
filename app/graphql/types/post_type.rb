# frozen_string_literal: true

module Types
  class PostType < Types::BaseObject
    include Rails.application.routes.url_helpers

    field :id, ID, null: false
    field :title, String
    field :description, String
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :user_id, Integer, null: false
    field :image, String

    def image
      rails_blob_url(object.image) if object.image.attached?
    end

    field :commentsCount, Integer, null: false do
      description 'brings all the posts count'
    end
    def commentsCount
      object.comments.count
    end
  end
end
