class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: %i[]
  before_action :set_comment, only: %i[edit destroy]

  def new
    @post = Post.find(params[:post_id])
    @comment = Comment.new(parent_id: params[:parent_id])
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params)

    if @comment.save
      redirect_to @post, notice: "comment created successfully!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @post = Post.find(params[:post_id]) 
  end

  def update
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])

    if @comment.update(comment_params)
      redirect_to @post, notice: "comment updated successfully!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment.destroy

    redirect_to @post, notice: "comment deleted successfully!"
  end

  private

  def set_post
    @post = current_user.posts.find_by(id: params[:post_id])
  end

  def set_comment
    @comment = current_user.comments.find_by(id: params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content, :parent_id).merge(user: current_user)
  end
end
