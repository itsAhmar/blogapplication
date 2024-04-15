module Mutations
  class CreatePost < BaseMutation
    field :post, Types::PostType, null: true
    field :errors, [String], null: false

    argument :title, String, required: true
    argument :description, String, required: true
    # argument :image, File
    # argument :image, ApolloUploadServer::Upload, required: false

    def resolve(input)
      post = Post.new(
        title: input[:title],
        description: input[:description],
        user_id: 1
      )

      if input.image
        # Assuming you have an attachment named 'image' on your Post model
        post.image.attach(input.image)
      end

      if post.save
        { post:, errors: [] }
      else
        { post: nil, errors: post.errors.full_messages }
      end
    end
  end
end
