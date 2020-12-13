module Types
  class WatchlistType < Types::BaseObject
    field :symbol, String, null: false
    field :name, String, null: false
  end
end
