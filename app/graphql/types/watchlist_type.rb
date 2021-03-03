module Types
  class WatchlistType < Types::BaseObject
    field :symbols, [String], null: true
    field :quotes, [Types::WatchlistIexQuoteType], null: true
  end
end
