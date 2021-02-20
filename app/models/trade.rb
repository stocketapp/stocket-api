class Trade < ApplicationRecord
  belongs_to :user
  validates :symbol, presence: true
  validates :price, presence: true
  validates :quantity, presence: true
  validates :order_type, presence: true
  validates :reference_id, presence: true, uniqueness: true
  validates :total, presence: true

  def self.get_trades(user)
    self.all
  end
end
