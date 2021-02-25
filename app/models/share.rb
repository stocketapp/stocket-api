class Share < ApplicationRecord
  belongs_to :user

  def self.buy(t)
    shares = []
    for i in 1..t[:quantity] do
      shares.push({
        user_id: t[:user_id],
        symbol: t[:symbol],
        price: t[:price],
        trade_reference_id: t[:reference_id]
      })
    end
    Share.create!(shares) do |s|
      user = User.find_by id: t[:user_id]
      new_value = user[:cash] - t[:total]
      
      User.update(t[:user_id], cash: new_value)
    end
  end

  def self.sell(t)
    symbol = t[:symbol]
    shares = Share.where symbol: symbol
    trade_qtty = t[:quantity]
    
    if shares.length >= trade_qtty
      ids = shares.last(trade_qtty).map { |el| el[:id] }
      Share.where(id: ids).destroy_all
      user = User.find_by! id: t[:user_id]
      User.update(user[:id], cash: user[:cash] + t[:total])
    end
  end
end