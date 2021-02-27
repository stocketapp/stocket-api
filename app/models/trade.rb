class Trade < ApplicationRecord
  belongs_to :user
  validates :symbol, presence: true
  validates :price, presence: true
  validates :quantity, presence: true
  validates :order_type, presence: true
  validates :reference_id, presence: true, uniqueness: true
  validates :total, presence: true

  def buy
    share = {
      user_id: self.user_id,
      symbol: self.symbol,
      price: self.price,
      trade_reference_id: self.reference_id,
      size: self.quantity,
      purchase_value: self.total
    }
    Share.create!(share) do |s|
      user = User.find_by id: self.user_id
      new_value = user[:cash] - self.total
      
      User.update(self.user_id, cash: new_value)
    end
  end

  def sell
    symbol = self.symbol
    share = Share.find_by symbol: symbol, user_id: self.user_id

    if share.size <= self.quantity
      share.destroy!
    else
      share.update(size: share[:size] - self.quantity)
      User.update(user[:id], cash: user[:cash] + self.total)
    end
  end
end
