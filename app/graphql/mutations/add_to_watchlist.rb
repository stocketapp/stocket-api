module Mutations
  # AddToWatchlistMutation
  class AddToWatchlist < BaseMutation
    argument :symbol, String, required: true

    type Types::WatchlistIexQuoteType

    def resolve(symbol: nil)
      user_id = context[:current_user][:id]
      w = Watchlist.create!(user_id: user_id, symbol: symbol)
      { id: w.id }.merge(w.iex_quote)
    end
  end
end
