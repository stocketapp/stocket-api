module Mutations
  class AddToWatchlist < BaseMutation
    argument :symbol, String, required: true

    field :id, ID, null: true
    field :symbol, String, null: true

    def resolve(symbol: nil)
      user_id = context[:current_user][:id]
      Watchlist.create!(user_id: user_id, symbol: symbol)
    end
  end
end