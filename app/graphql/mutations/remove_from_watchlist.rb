module Mutations
  class RemoveFromWatchlist < BaseMutation
    argument :symbol, String, required: true

    def resolve(symbol: nil)
      uid = context[:current_user][:id]
      Watchlist.remove_from_watchlist(symbol, uid)
      nil
    end
  end
end