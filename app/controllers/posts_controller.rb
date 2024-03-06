class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]
  before_action :authenticate_user!, only: %i[show new create edit update destroy]

  def index
    @posts = Post.order(id: :desc).includes(:user)
  end

  def show
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def edit; end

  def create
    @post = Post.new(post_params.merge(user: current_user))

    if @post.save
      redirect_to posts_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    res = @post.update(post_params.merge(user: current_user))

    if @post.save
      redirect_to @post
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_url
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :description, :image)
  end
end
