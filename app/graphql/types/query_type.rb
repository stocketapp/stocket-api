module Types
  class QueryType < Types::BaseObject
    field :get_trade, [Types::TradesType], null: false

    def get_trade
      Trade.get_trades(context[:current_user])
    end
  end
end
