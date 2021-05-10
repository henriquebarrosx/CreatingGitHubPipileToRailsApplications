class Bid < ApplicationRecord
  belongs_to :auction, class_name: 'Auction'
  belongs_to :bidder, class_name: 'User'

  validates_presence_of :bidder_id
end
