module Types
  class WatchlistIexQuoteType < Types::BaseObject
    field :symbol, String, null: true
    field :companyName, String, null: true
    field :logo, String, null: true
    field :latestPrice, Float, null: true
    field :change, Float, null: true
    field :changePercent, Float, null: true
    field :id, Integer, null: false
  end
end
