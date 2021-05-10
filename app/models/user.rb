class User < ApplicationRecord
  has_many :auctions
  validates_presence_of :email, :password
end
