class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: %i[new create edit update]
  before_action :set_comment, only: %i[edit destroy]

  def new
    @comment = Comment.new(parent_id: params[:parent_id])
  end

  def create
    @comment = @post.comments.create(comment_params)

    if @comment.save
      redirect_to @post
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    @comment = @post.comments.find(params[:id])

    if @comment.update(comment_params)
      redirect_to @post
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post = @comment.post

    if @comment.destroy
      redirect_to @post
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content, :parent_id).merge(user: current_user)
  end
end
