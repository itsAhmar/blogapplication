class LikesController < ApplicationController
	include ActionView::RecordIdentifier

  def create
  	@like = current_user.likes.create(like_params)

  	if @like.save
  		respond_to do |format|
    		format.turbo_stream { render turbo_stream: turbo_stream.replace("like_#{dom_id(@like.likeable)}", partial: "likes/button", locals: { likeable: @like.likeable }) }
    	end
  	end
  end


  def destroy
  	@like = current_user.likes.find(params[:id])
  	@l = @like
  	
  	if @like.destroy
  		respond_to do |format|
    		format.turbo_stream { render turbo_stream: turbo_stream.replace("like_#{dom_id(@like.likeable)}", partial: "likes/button", locals: { likeable: @l.likeable }) }
    	end
    end
  end

  private

  def like_params
  	params.require(:like).permit(:likeable_id, :likeable_type)
  end

end
