require 'rails_helper'

RSpec.describe User, type: :model do
  subject do
    User.new(
      email: 'name@example.com',
      password: '123456'
    )
  end

  describe 'Validate user creation' do
    it 'Should be valid if has email and password' do
      expect(subject).to be_valid
    end

    it 'Should throw a exception if don\'t have password' do
      subject.password = nil
      expect(subject).to_not be_valid
    end
  end
end
