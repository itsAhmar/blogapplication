class CommentsController < ApplicationController

	before_action :set_post, only: %i[new create edit update]

	def new
		@comment = Comment.new
	end


	def create
		@comment = @post.comments.create(comment_params.merge(user: current_user))
		
		if @comment.save
			redirect_to post_path(@post)
		else
			render :new , status: :unprocessable_entity
		end
	 end


	def edit
		@comment = Comment.find(params[:id])
	end


	def update
		@comment = @post.comments.find(params[:id])

		if @comment.update(comment_params.merge(user: current_user))
			redirect_to post_path(@post)
		else
			render :edit , status: :unprocessable_entity 
		end
	end

			
	def destroy
		@comment = Comment.find(params[:id])

		@post = @comment.post
		
		if @comment.destroy
			redirect_to post_path(@post)
		end
	end


	private

	def set_post
		@post = Post.find(params[:post_id])
	end

	def comment_params
		params.require(:comment).permit(:content , :parent_id)
	end

end