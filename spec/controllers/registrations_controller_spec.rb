# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::RegistrationsController do
  let(:user_invalid) { create :user, email: nil }

  before do
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new user' do
        user_params = attributes_for(:user)
        expect { post :create, params: { user: user_params } }.to change(User, :count).by(1)
        expect(response).to redirect_to(root_path)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new user' do
        user_params = attributes_for(:user, email: nil)
        post :create, params: { user: user_params }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(User.create(user_params).errors[:email]).to include("can't be blank")
      end
    end
  end
end
