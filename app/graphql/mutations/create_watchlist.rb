module Mutations
  class CreateWatchlist < BaseMutation
    argument :symbol, String, required: true
    argument :name, String, required: true
    argument :user_id, ID, required: true

    type Types::WatchlistType

    def resolve(symbol: nil, name: nil, user_id: nil)
      Watchlist.create!(user_id: user_id, symbol: symbol, name: name)
    end
  end
end