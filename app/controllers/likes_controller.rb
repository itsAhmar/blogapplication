# frozen_string_literal: true

# Controller responsible for managing likes on various resources.
class LikesController < ApplicationController
  include ActionView::RecordIdentifier

  def create
    @like = current_user.likes.new(like_params)

    return unless @like.save

    like_stream
  end

  def destroy
    @like = current_user.likes.find(params[:id])
    @likee = @like

    return unless @likee.destroy

    like_stream
  end

  private

  def like_stream
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          "like_#{dom_id(@like.likeable)}",
          partial: 'likes/button',
          locals: { likeable: @like.likeable }
        )
      end
    end
  end

  def like_params
    params.require(:like).permit(:likeable_id, :likeable_type)
  end
end
