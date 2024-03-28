# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CommentsController do
  let(:user) { create(:user) }
  let(:user_post) { create(:post, user:) }
  let!(:parent_comment) { create(:comment, user:, post: user_post) }
  let!(:child_comment) { create(:comment, user:, post: user_post, parent_id: parent_comment.id) }
  let(:valid_attributes) { { content: 'Updated comment content', parent_id: nil, user_id: user.id } }
  let(:invalid_attributes) { { content: '', parent_id: nil, user_id: user.id } }

  before do
    sign_in user
  end

  describe 'GET #new' do
    it 'assigns a new comment as @comment' do
      get :new, params: { parent_id: nil, post_id: post.id }
      expect(assigns(:comment)).to be_a_new(Comment)
      expect(assigns(:comment).parent_id).to be_nil
    end

    it 'assigns a new comment with parent_id if provided' do
      get :new, params: { parent_id: parent_comment.id, post_id: post.id }
      expect(assigns(:comment)).to be_a_new(Comment)
      expect(assigns(:comment).parent_id).to eq(parent_comment.id)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested comment as @comment and render edit template' do
      get :edit, params: { id: parent_comment.id, post_id: post.id }
      expect(assigns(:comment)).to eq(parent_comment)
      expect(response).to render_template('edit')
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested comment and redirects to the post with a notice ' do
      expect do
        delete :destroy, params: { id: parent_comment.id, post_id: post.id }
      end.to change(Comment, :count).by(- 1 - parent_comment.comments.count)
      expect(response).to redirect_to(post)
      expect(flash[:notice]).to eq('comment deleted successfully!')
    end
  end

  describe 'Post #create' do
    context 'with valid params' do
      it 'creates a new comment and redirects' do
        comment_params = attributes_for(:comment, user_id: user.id, parent_id: nil)
        expect do
          post :create, params: { post_id: user_post.id, comment: comment_params }
        end.to change(Comment, :count).by(1)
        expect(response).to redirect_to(user_post)
        expect(flash[:notice]).to eq('comment created successfully!')
      end
    end

    context 'with invalid params' do
      it 'does not create a new comment and re-render the new template' do
        invalid_attributes = attributes_for(:comment, user_id: user.id, parent_id: nil, content: '')
        expect do
          post :create, params: { post_id: user_post.id, comment: invalid_attributes }
        end.to_not change(Comment, :count)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid params' do
      it 'updates the requested comment and redirects with flash message' do
        patch :update, params: { post_id: user_post.id, id: parent_comment.id, comment: valid_attributes }
        parent_comment.reload
        expect(parent_comment.content).to eq('Updated comment content')
        expect(response).to redirect_to(user_post)
        expect(flash[:notice]).to eq('comment updated successfully!')
      end
    end

    context 'with invalid params' do
      it 'does not update the comment andd re-render edit template' do
        patch :update, params: { post_id: user_post.id, id: parent_comment.id, comment: invalid_attributes }
        parent_comment.reload
        expect(parent_comment.content).not_to eq('')
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response).to render_template(:edit)
      end
    end
  end
end
