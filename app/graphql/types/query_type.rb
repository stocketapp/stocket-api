require 'json'

# Types
module Types
  # QueryType
  class QueryType < Types::BaseObject
    field :user, Types::UserType, null: false
    field :watchlist, Types::WatchlistType, null: true
    field :quote, Types::IexQuoteType, null: false do
      argument :symbol, String, required: true
    end
    field :position, Types::PositionType, null: false do
      argument :symbol, String, required: true
    end
    field :trades, [Types::TradeType], null: false
    field :balance_history, [Types::BalanceHistoryType], null: false, resolver_method: :balance_history
    field :portfolio_value, Types::PortfolioValueType, null: false

    def user
      User.find_by! uid: context[:current_user][:uid]
    end

    def watchlist
      Watchlist.watchlist_prices(context[:current_user][:id])
    end

    def quote(symbol:)
      Watchlist.find_by!(symbol: symbol, user_id: context[:current_user][:uid]).iex_quote
    end

    def position(symbol:)
      shares = Share.where symbol: symbol, user_id: context[:current_user][:id]
      latest_price = Share.iex_price(symbol)
      yesterday_price = Share.iex_yesterday_price(symbol)

      {
        symbol: symbol,
        shares: shares,
        latest_price: latest_price,
        yesterday_price: yesterday_price,
      }
    end

    def trades
      Trade.where user_id: context[:current_user][:id]
    end

    def balance_history
      BalanceHistory.where user_id: context[:current_user][:id]
    end

    def portfolio_value
      PortfolioValue.calculate id: context[:current_user][:id]
    end
  end
end
