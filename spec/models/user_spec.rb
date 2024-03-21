require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create :user }
  context 'when creating a user with valid attributes' do

    it 'has only expected associations' do
      expected_associations = [:posts, :comments, :likes]

      actual_associations = User.reflect_on_all_associations.map(&:name)

      actual_associations -= [:image_attachment, :image_blob]

      unexpected_associations = actual_associations - expected_associations
      expect(unexpected_associations).to be_empty, "Unexpected associations found: #{unexpected_associations}"
    end

    it 'is valid' do
      expect(user).to be_valid
    end
  end

  context 'when creating a user with invalid attributes' do

    it 'is invalid without any attributes' do
      user = User.new
      expect(user).to_not be_valid
      expect(user.errors).to_not be_empty
    end

    it 'rejects when email is missing' do
      user.email = nil
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include("can't be blank")
    end

    it 'rejects when username is missing' do
      user.username = nil
      expect(user).not_to be_valid
      expect(user.errors[:username]).to include("can't be blank")
    end

    it 'rejects when image is missing' do
      user.image = nil
      expect(user).to_not be_valid
      expect(user.errors[:image]).to include("can't be blank")
    end

    it 'when password is missing' do
      user.password = nil
      expect(user).to_not be_valid
      expect(user.errors[:password]).to include("can't be blank")
    end
  end

  context 'when testing user associations' do
    # testing associations
    it 'has many posts' do
      expect(User.reflect_on_association(:posts).macro).to eq(:has_many)
    end

    it 'has many comments' do
      expect(User.reflect_on_association(:comments).macro).to eq(:has_many)
    end

    it 'has many likes' do
      expect(User.reflect_on_association(:likes).macro).to eq(:has_many)
    end
  end

  context 'with dependent destroy associations' do
    let(:post) { create :post, user: }
    let(:comment) { create :comment, user:, post: }

    it 'destroys associated posts when user is deleted' do
      expect { user.destroy }.to change { Post.count }.by(- user.posts.count)
    end

    it 'destroys associated comments when user is deleted' do
      expect { user.destroy }.to change { Comment.count }.by(- user.comments.count)
    end

    it 'destroys associated like of type post when user is deleted' do
      create(:like, user:, likeable: post)
      expect { user.destroy }.to change { Like.count }.by(- user.likes.count)
    end
  end
end
