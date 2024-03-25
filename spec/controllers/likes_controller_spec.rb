require 'rails_helper'

RSpec.describe LikesController do
  let(:user) { create(:user) }
  let(:user_post) { create(:post, user:) }
  let(:valid_like_params) { { likeable_id: user_post.id, likeable_type: 'Post' } }
  let(:invalid_like_params) { { likeable_id: nil, likeable_type: 'Post' } }
  let!(:like) { create(:like, user:, likeable_id: user_post.id, likeable_type: 'Post') }

  before do
    sign_in user
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new like and respond with turbo stream' do
        expect do
          post :create, params: { like: valid_like_params }, format: :turbo_stream
        end.to change(user.likes, :count).by(1)
        expect(response).to have_http_status(:success)
        expect(response.content_type).to start_with('text/vnd.turbo-stream.html')
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new like and respond with no content' do
        expect do
          post :create, params: { like: invalid_like_params }, format: :turbo_stream
        end.not_to change(user.likes, :count)
        expect(response).to have_http_status(:no_content)
      end
    end
  end

  describe 'Delete #destroy' do
    context 'when the like exists and belongs to the current user' do
      it 'destroys the like' do
        expect do
          delete :destroy, params: { id: like.id }, format: :turbo_stream
        end.to change(user.likes, :count).by(-1)
        expect(response).to have_http_status(:success)
        expect(response.content_type).to start_with('text/vnd.turbo-stream.html')
      end
    end

    context 'when the like does not exist' do
      it 'does not destroy the like' do
        expect do
          delete :destroy, params: { id: 9999 }, format: :turbo_stream
        end.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
