require 'rails_helper'

RSpec.describe PostsController do
  let(:user) { create :user }
  let!(:posts) { create_list :post, 10, user: }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
      expect(response.code).to eq('200')
    end

    it 'assigns @posts' do
      get :index
      expect(assigns(:posts).sort_by(&:id)).to eq(posts)
    end

    it 'renders the scrollable_list template when page param is present' do
      get :index, params: { page: 1 }
      expect(response).to render_template('scrollable_list')
    end

    it 'check pagination working and gives 10 posts per page' do
      get :index
      expect(assigns(:posts).count).to eq(10)
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      post = posts.sample
      get :show, params: { id: post.id }
      expect(response).to be_successful
      expect(response.code).to eq('200')
    end

    it 'assigns @parent_comments' do
      post = posts.sample
      comment1 = create(:comment, user:, post:, parent_id: nil)
      comment2 = create(:comment, user:, post:, parent_id: nil)
      get :show, params: { id: post.id }
      expect(assigns(:parent_comments)).to eq([comment1, comment2])
    end

    it 'initializes a new comment' do
      post = posts.sample
      get :show, params: { id: post.id }
      expect(assigns(:comment)).to be_a_new(Comment)
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new
      expect(response).to be_successful
      expect(response.code).to eq('200')
    end

    it 'initializes a new post' do
      get :new
      expect(assigns(:post)).to be_a_new(Post)
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      post = posts.sample
      get :edit, params: { id: post }
      expect(response).to be_successful
      expect(response.code).to eq('200')
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new post and redirects' do
        post_params = attributes_for(:post, user_id: user.id)
        expect do
          post :create, params: { post: post_params }
        end.to change(Post, :count).by(1)
        expect(response).to redirect_to(posts_path)
        expect(flash[:notice]).to be_present
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new post and render the new template' do
        post_params = { title: '', content: 'Test Content' }
        expect do
          post :create, params: { post: post_params }
        end.not_to change(Post, :count)
        expect(response).to render_template(:new)
        expect(response.status).to eq(422)
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid parameters' do
      it 'updates the post' do
        post = posts.sample
        patch :update, params: { id: post.id, post: { title: 'Updated Title' } }
        post.reload
        expect(post.title).to eq('Updated Title')
        expect(response).to redirect_to(post)
        expect(flash[:notice]).to be_present
      end
    end

    context 'with invalid parameters' do
      it 'does not update the post' do
        post = posts.sample
        patch :update, params: { id: post.id, post: { title: '' } }
        post.reload
        expect(post.title).not_to be_empty
        expect(response).to render_template(:edit)
        expect(response.status).to eq(422)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the post' do
      post = posts.sample
      expect do
        delete :destroy, params: { id: post.id }
      end.to change(Post, :count).by(-1)
    end

    it 'redirects to posts index' do
      post = posts.sample
      delete :destroy, params: { id: post.id }
      expect(response).to redirect_to(posts_path)
      expect(flash[:notice]).to be_present
    end
  end
end
