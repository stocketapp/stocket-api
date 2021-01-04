class Watchlist < ApplicationRecord
  belongs_to :user
  validates :symbol, presence: true, uniqueness: true

  def self.watchlist_prices(user_id)
    list = Watchlist.where user_id: user_id
    symbols = list.map { |el| el.symbol }.join(',')
    self.fetch_iex_quote(symbols).map { |el| el[1]['quote'] }
  end

  def self.remove_item(symbol, uid)
    item = Watchlist.find_by user_id: uid, symbol: symbol
    item.destroy
  end

  def get_quote
    Watchlist.fetch_iex_quote(self.symbol)[self.symbol]['quote']
  end
end
