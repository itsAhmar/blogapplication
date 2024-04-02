# frozen_string_literal: true

# Controller responsible for managing posts
module Api
  class PostsController < ApplicationController
    # before_action :authenticate_user!, except: %i[index]
    before_action :set_post, only: %i[show]

    def index
      @posts = Post.order(id: :desc).includes(:user)
      render json: @posts
    end

    def show
      @parent_comments = @post.comments.includes(:user, :likes).where(parent_id: nil).order(:created_at)
      @comment = Comment.new
      render json: @parent_comments
    end

    def new
      @post = Post.new
      render json: @post
    end

    private

    def set_post
      @post = Post.find(params[:id])
    end

    def set_user_post
      @post = current_user.posts.find_by(id: params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :description, :image, :user_id)
    end
  end
end
