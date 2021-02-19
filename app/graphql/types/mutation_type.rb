module Types
  class MutationType < Types::BaseObject
    field :create_user, mutation: Mutations::CreateUser
    field :add_to_watchlist, mutation: Mutations::AddToWatchlist
    field :remove_from_watchlist, mutation: Mutations::RemoveFromWatchlist
    field :create_trade, mutation: Mutations::CreateTrade
  end
end
