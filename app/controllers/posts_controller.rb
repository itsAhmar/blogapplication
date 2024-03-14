class PostsController < ApplicationController
  before_action :authenticate_user!, except: %i[index]
  before_action :set_post, only: %i[edit update destroy]

  def index
    @posts = Post.order(id: :desc).includes(:user)
  end

  def show
    @post = Post.find(params[:id])
    @parent_comments = @post.comments.includes(:user).where(parent_id: nil).order(:created_at)
    @comment = Comment.new
    @like_button = @post.likes.find_by(user_id: current_user.id)
  end

  def new
    @post = Post.new
  end

  def edit; end

  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to posts_path, notice: "post created successfully!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: "post updated successfully!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: "post deleted successfully!"
  end

  private

  def set_post
    @post = current_user.posts.find_by(id: params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :description, :image).merge(user: current_user)
  end
end
