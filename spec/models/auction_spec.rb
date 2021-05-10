require 'rails_helper'

RSpec.describe Auction, type: :model do
  let :seller do
    User.new(
      email: 'name@example.com',
      password: '123456'
    )
  end

  subject do
    Auction
      .new(
        user_id: User.last,
        title: 'Anything',
        description: 'Lorem ipsum',
        start_date: DateTime.now,
        end_date: DateTime.now + 1.week
      )
  end

  describe 'Validate auction creation' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a title' do
      subject.title = nil
      expect(subject).to be_invalid
    end
  end

  describe 'Validate model associations' do
    it { should belong_to(:user).without_validating_presence }
  end
end
