require 'rails_helper'

RSpec.describe Bid, type: :model do
  describe 'Validate associations' do
    it { should belong_to(:auction) }
    it { should belong_to(:bidder).without_validating_presence }
  end
end
