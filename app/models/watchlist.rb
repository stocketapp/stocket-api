# Watchlist model
class Watchlist < ApplicationRecord
  belongs_to :user
  validates :symbol, presence: true, uniqueness: true

  # Returns an Hash with `quotes` and `logos` for each symbol that exists in the user's Watchlist
  # @param [String] user_id
  # @return [Hash{String->Unknown}]
  def self.watchlist_prices(user_id)
    watchlist = Watchlist.where user_id: user_id
    symbols = symbols_list(watchlist)
    quotes = nil
    if symbols.size.positive?
      quotes = fetch_iex_batch_quote(symbols.join(',')).map do |q|
        # Array at position 0 (q[0]) is "symbol"; This is because the returned object is actually an array
        # that looks like this: ['SYMBOL', { quote: {} }]
        logo = { 'logo' => "https://storage.googleapis.com/iex/api/logos/#{q[0]}.png" }
        # Return a custom object with the watchlist item ID merged with the IEX quote of each symbol.
        # This also merges a hash key with the company's logo
        { 'id' => watchlist.find_by(symbol: q[0]).id }.merge(logo).merge(q[1]['quote'])
      end
    end

    { 'quotes' => quotes, 'symbols' => symbols }
  end

  def self.remove_item(symbol, uid)
    item = Watchlist.find_by user_id: uid, symbol: symbol
    item.destroy
  end

  # Returns an array of symbol strings: ['AAPL', 'AMZN', 'MSFT']
  # @param [Array] watchlist
  # @return [Array]
  def self.symbols_list(watchlist)
    watchlist.map(&:symbol)
  end
end
