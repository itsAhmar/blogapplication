# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    # get all the posts
    field :getPosts, [Types::PostType], null: false

    def getPosts
      Post.all
    end

    field :getPost, Types::PostType, null: false do
      argument :id, ID, required: true
    end

    def getPost(id:)
      Post.find(id)
    end
  end
end
