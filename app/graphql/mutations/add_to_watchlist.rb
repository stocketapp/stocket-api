module Mutations
  # AddToWatchlistMutation
  class AddToWatchlist < BaseMutation
    argument :symbol, String, required: true

    type Types::WatchlistIexQuoteType

    def resolve(symbol: nil)
      user_id = context[:current_user][:id]
      w = Watchlist.create!(user_id: user_id, symbol: symbol)
      create_watchlist_item({ id: w.id }.merge(w.iex_quote))
    end

    private

    def create_watchlist_item(item)
      {
        symbol: item['symbol'],
        change: item['change'],
        changePercent: item['change_percent'],
        companyName: item['company_name'],
        latestPrice: item['latest_price'],
        id: item[:id],
        logo: item['logo']
      }
    end
  end
end
