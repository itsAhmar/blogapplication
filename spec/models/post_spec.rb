# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { create :user }
  let(:post) { create :post, user: }

  context 'when creating a post with valid attributes' do
    it 'has only expected associations' do
      expected_associations = %i[comments likes user]

      actual_associations = Post.reflect_on_all_associations.map(&:name)

      actual_associations -= %i[image_attachment image_blob]

      unexpected_associations = actual_associations - expected_associations
      expect(unexpected_associations).to be_empty, "Unexpected associations found: #{unexpected_associations}"
    end

    it 'is valid' do
      expect(post).to be_valid
    end
  end

  context 'when creating a post with invalid attributes' do
    it 'is invalid without any attributes' do
      post = Post.new
      expect(post).to_not be_valid
      expect(post.errors).to_not be_empty
    end

    it 'rejects when title is missing' do
      post.title = nil
      expect(post).not_to be_valid
      expect(post.errors[:title]).to include("can't be blank")
    end

    it 'rejects when description is missing' do
      post.description = nil
      expect(post).not_to be_valid
      expect(post.errors[:description]).to include("can't be blank")
    end

    it 'rejects when image is missing' do
      post.image = nil
      expect(post).to_not be_valid
      expect(post.errors[:image]).to include("can't be blank")
    end
  end

  context 'when testing post associations' do
    it 'has many comments' do
      expect(Post.reflect_on_association(:comments).macro).to eq(:has_many)
    end

    it 'has many likes' do
      expect(Post.reflect_on_association(:likes).macro).to eq(:has_many)
    end
  end

  context 'with dependent destroy associations' do
    let(:comment) { create :comment, user:, post: }

    it 'destroys associated comments when post is deleted' do
      expect { post.destroy }.to change { Comment.count }.by(- post.comments.count)
    end

    it 'destroys associated likes when post is deleted' do
      create(:like, user:, likeable: post)
      expect { post.destroy }.to change { Like.count }.by(- post.likes.count)
    end
  end
end
