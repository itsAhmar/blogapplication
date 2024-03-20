require 'rails_helper'

RSpec.describe User, type: :model do
  context 'when creating a user with valid attributes' do
    let(:user) { create :user }

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

    # it 'has an attached image' do
    #   expect(user.image).to be_attached
    # end

    # it 'validates presence of username' do
    #   expect(user.username).to be_valid
    # end

    # it 'validates presence of email' do
    #   expect(user).to validate_presence_of(:email)
    # end

    # it 'validates presence of password' do
    #   expect(user).to validate_presence_of(:password)
    # end
  end

  context 'when creating a user with invalid attributes' do

    it 'is invalid without any attributes' do
      user = User.new
      expect(user).to_not be_valid
      expect(user.errors).to_not be_empty
    end

    it 'rejects when email is missing' do
      user = build(:user, email: nil)
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include("can't be blank")
    end

    it 'rejects when username is missing' do
      user = build(:user, username: nil)
      expect(user).not_to be_valid
      expect(user.errors[:username]).to include("can't be blank")
    end

    it 'rejects invalid image attachment' do
      user = build(:user, image: nil)
      expect(user).to_not be_valid
      expect(user.errors[:image]).to include("can't be blank")
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
  end



















    # it 'requires a password on creation' do
    #   user2 = build(:user, password: nil) # Create a user without a password
    #   expect(user2.valid?).to eq false # Ensure the user is not valid without a password
    # end

    # it 'requires a password on creation' do
    #   user2 = build(:user) # Create a user without a password
    #   expect(user2.valid?).to eq true # Ensure the user is not valid without a password
    # end

    # it 'requires a password on creation' do
    #   user2 = build(:user, password: nil) # Create a user without a password
    #   expect(user2.valid?).to eq false # Ensure the user is not valid without a password
    #   expect(user2.errors[:password]).to include("can't be blank") # Ensure there is an error message for password presence
    # end

    # it 'requires a password with minimum 6 characters on creation' do
    #   user2 = build(:user, password: '12345') # Create a user with a short password
    #   expect(user2.valid?).to eq false # Ensure the user is not valid with a short password
    #   expect(user2.errors[:password]).to include("is too short (minimum is 6 characters)") # Ensure there is an error message for password length
    # end

     # Negative test cases
    # it 'should not have any other associations' do
    #   unexpected_associations = User.reflect_on_all_associations.map(&:name) - [:posts, :comments, :likes]
    #   expect(unexpected_associations).to be_empty
    # end

  
end



