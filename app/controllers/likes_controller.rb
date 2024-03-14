class LikesController < ApplicationController
	include ActionView::RecordIdentifier

  def create
  	@like = current_user.likes.new(like_params)

  	if @like.save
 			like_stream
  	end
  end

  def destroy
  	@like = current_user.likes.find(params[:id])
  	@likee = @like

  	if @likee.destroy
  		like_stream
    end
  end

  private

  def like_stream
  	respond_to do |format|
    	format.turbo_stream { render turbo_stream: turbo_stream.replace("like_#{dom_id(@like.likeable)}", partial: "likes/button", locals: { likeable: @like.likeable }) }
    end
  end

  def like_params
  	params.require(:like).permit(:likeable_id, :likeable_type)
  end
end
