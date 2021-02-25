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

  def buy
    shares = []
    for i in 1..self.quantity do
      shares.push({
        user_id: self.user_id,
        symbol: self.symbol,
        price: self.price,
        trade_reference_id: self.reference_id
      })
    end
    Share.create!(shares) do |s|
      user = User.find_by id: self.user_id
      new_value = user[:cash] - self.total
      
      User.update(self.user_id, cash: new_value)
    end
  end

  def sell
    symbol = self.symbol
    shares = Share.where symbol: symbol
    trade_qtty = self.quantity
    
    if shares.length >= trade_qtty
      ids = shares.last(trade_qtty).map { |el| el[:id] }
      Share.where(id: ids).destroy_all
      user = User.find_by! id: self.user_id
      User.update(user[:id], cash: user[:cash] + self.total)
    end
  end
end
