class User < ApplicationRecord
  has_many :trades
  has_many :shares
  has_many :balance_histories
  has_many :watchlists

  validates :email, presence: true, uniqueness: true
  validates :uid, presence: true, uniqueness: true
end
