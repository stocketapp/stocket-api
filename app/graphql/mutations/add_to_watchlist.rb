module Mutations
  class AddToWatchlist < BaseMutation
    argument :symbol, String, required: true

    type Types::IexQuoteType

    def resolve(symbol: nil)
      user_id = context[:current_user][:id]
      Watchlist.create!(user_id: user_id, symbol: symbol).get_quote
    end
  end
end