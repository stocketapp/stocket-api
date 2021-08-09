module Mutations
  # RemoveFromWatchlist
  class RemoveFromWatchlist < BaseMutation
    argument :symbol, String, required: true

    field :symbol, String, null: false

    def resolve(symbol: nil)
      uid = context[:current_user][:id]
      Watchlist.remove_item(symbol, uid)
      { symbol: symbol }
    end
  end
end
