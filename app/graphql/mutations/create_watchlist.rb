module Mutations
  class CreateWatchlist < BaseMutation
    argument :symbol, String, required: true

    type Types::WatchlistType

    def resolve(symbol: nil)
      user_id = context[:current_user][:id]
      Watchlist.create!(user_id: user_id, symbol: symbol)
    end
  end
end