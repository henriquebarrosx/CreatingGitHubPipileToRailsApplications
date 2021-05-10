require 'rails_helper'

RSpec.describe Auction, type: :model do
  subject do
    Auction
      .new(
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
end
