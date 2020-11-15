module Types
  class QueryType < Types::BaseObject
    field :all_trades, [Types::TradesType], null: false

    def all_trades
      Trades.all
    end
  end
end
