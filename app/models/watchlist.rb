class Watchlist < ApplicationRecord
  belongs_to :user
  validates :symbol, presence: true, uniqueness: true

  def self.watchlist_prices(user_id)
    list = Watchlist.where user_id: user_id
    symbols = list.map { |el| el.symbol }
    quotes = nil
    if symbols.size > 0
      quotes = self.fetch_iex_batch_quote(list.map{ |w| w.symbol}.join(',')).map do |q|
        # q[0] = symbol - This is because the returned object looks like ['SYMBOL', { quote: {} }]
        logo = { "logo" => "https://storage.googleapis.com/iex/api/logos/#{q[0]}.png" }    
        { "id" => list.find_by(symbol: q[0]).id }.merge(logo).merge(q[1]['quote'])
      end
    end
    
    { "quotes" => quotes, "symbols" => symbols }
  end

  def self.remove_item(symbol, uid)
    item = Watchlist.find_by user_id: uid, symbol: symbol
    item.destroy
  end
end
