class Trade < ApplicationRecord
  def self.get_trades(user)
    self.all
  end
end
