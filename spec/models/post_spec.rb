require 'rails_helper'

RSpec.describe Post, type: :model do
  context 'when creating a post' do
    let(:post) { create(:post) }

    it 'should be valid post with all attributes' do
      expect(post.valid?).to be true
    end
  end
end
