# frozen_string_literal: true

# Controller responsible for managing posts
module Api
  # Controller responsible for managing posts within the API
  class PostsController < ApplicationController
    # before_action :authenticate_user!, except: %i[index]
    before_action :set_post, only: %i[show edit update destroy]

    def index
      @posts = Post.order(id: :desc).includes(:user)
      render json: @posts.map { |post| post_json_with_image_url(post) }
    end

    def show
      render json: post_json_with_image_url(@post)
    end

    def new
      @post = Post.new
      render json: @post
    end

    def create
      @post = Post.new(post_params)

      @post.user_id = 1 # For now setting user_id, unless we don't get current_user
      if @post.save
        render json: @post, status: :created
      else
        render json: @post.errors, status: :unprocessable_entity
      end
    end

    def edit
      render json: post_json_with_image_url(@post)
    end

    def update
      if @post.update(post_params)
        render json: @post, status: :ok
      else
        render json: @post.errors, status: :unprocessable_entity
      end
    end

    def destroy
      if @post.destroy
        render json: { message: 'Post deleted successfully' }, status: :ok
      else
        render json: { error: 'Failed to delete post' }, status: :unprocessable_entity
      end
    end

    private

    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :description, :image, :user_id)
    end

    def post_json_with_image_url(post)
      {
        id: post.id,
        title: post.title,
        description: post.description,
        user_id: post.user_id,
        image_url: post.image.attached? ? url_for(post.image) : nil
      }
    end
  end
end
