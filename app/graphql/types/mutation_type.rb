module Types
  class MutationType < Types::BaseObject
    field :create_user, mutation: Mutations::CreateUser
    field :signin_user, mutation: Mutations::SignInUser
    field :create_watchlist, mutation: Mutations::AddToWatchlist
    field :remove_from_watchlist, mutation: Mutations::RemoveFromWatchlist
  end
end
