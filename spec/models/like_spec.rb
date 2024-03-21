require 'rails_helper'

RSpec.describe Like, type: :model do

  let(:user) { create :user }
  let(:post) { create :post, user: user }
  let(:like) { create :like, user: user, likeable: post }
  let(:duplicate_like) { build :like, user: user, likeable: post }

  context "validations" do
    it "is invalid without a user_id" do
      like.user_id = nil
      expect(like).to_not be_valid
      expect(like.errors[:user]).to include("must exist")
    end

    it "validates uniqueness of user_id scoped to likeable_id and likeable_type" do
      like.save
      expect { duplicate_like.save! }.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: User has already been taken")
    end
  end
end