require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { create :user }
  let(:post) { create :post, user: }
  let(:comment) { create :comment , user: , post: }
  let(:child_comment) { create :comment, user:, post:, parent: comment}

  context 'when creating a comment with valid attributes' do

    it 'has only expected associations' do
      expected_associations = [:user, :likes, :comments]

      actual_associations = Post.reflect_on_all_associations.map(&:name)

      actual_associations -= [:image_attachment, :image_blob]

      unexpected_associations = actual_associations - expected_associations
      expect(unexpected_associations).to be_empty, "Unexpected associations found: #{unexpected_associations}"
    end

    it 'is valid' do
      expect(comment).to be_valid
    end
  end

  context 'when creating a comment with invalid attributes' do
    it 'is invalid without any attributes' do
      comment = Comment.new
      expect(comment).to_not be_valid
      expect(comment.errors).to_not be_empty
    end

    it 'rejects when content is missing' do
      comment.content = nil
      expect(comment).not_to be_valid
      expect(comment.errors[:content]).to include("can't be blank")
    end
  end

  context 'when testing comments associations' do
    it 'has many likes' do
      expect(Comment.reflect_on_association(:likes).macro).to eq(:has_many)
    end

    it 'has many comments' do
      expect(Comment.reflect_on_association(:comments).macro).to eq(:has_many)
    end
  end

  context 'with dependent destroy associations' do

    it 'destroys associated likes when comment is deleted' do
      expect { comment.destroy }.to change { Like.count }.by(- comment.likes.count)
    end

    it "destroys associated child comments when parent comment is destroyed" do
      expect { comment.destroy }.to change { Comment.count }.by(- 1 - comment.comments.count)
    end
  end

end
