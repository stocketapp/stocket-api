require 'json'

# Types
module Types
  # QueryType
  class QueryType < Types::BaseObject
    field :user, Types::UserType, null: false
    field :watchlist, Types::WatchlistType, null: true
    field :trades, [Types::TradeType], null: false
    field :balance_history, [Types::BalanceHistoryType], null: false, resolver_method: :balance_history
    field :portfolio, Types::PortfolioType, null: false
    field :quote, Types::IexQuoteType, null: false do
      argument :symbol, String, required: true
    end
    field :position, Types::PositionType, null: false do
      argument :symbol, String, required: true
      argument :price, Float, required: false
    end
    field :chart, [Types::IexChartType], null: false do
      argument :symbol, String, required: true
    end
    field :intraday, [Types::IexChartType], null: true do
      argument :symbol, String, required: true
      argument :range, String, required: false
    end
    field :price, Float, null: true do
      argument :symbol, String, required: true
    end

    def user
      User.find_by! uid: context[:current_user][:uid]
    end

    def watchlist
      Watchlist.watchlist_prices(context[:current_user][:id])
    end

    def quote(symbol:)
      ApplicationRecord.iex_quote(symbol)
    end

    def position(symbol:, price: nil)
      shares = Share.where symbol: symbol, user_id: context[:current_user][:id]
      latest_price = price.nil? ? Share.iex_price(symbol) : price

      {
        symbol: symbol,
        shares: shares,
        latest_price: latest_price
      }
    end

    def trades
      Trade.where user_id: context[:current_user][:id]
    end

    def balance_history
      BalanceHistory.where user_id: context[:current_user][:id]
    end

    def portfolio
      # TODO: Use PortfolioType instead. Optimize this query!!!
      portfolio = Portfolio.new(user_id: context[:current_user][:id])
      {
        value: portfolio.value,
        change: portfolio.change,
        change_pct: portfolio.change_pct,
        positions: portfolio.positions
      }
    end

    def chart(symbol:)
      ApplicationRecord.iex_chart(symbol)
    end

    def intraday(symbol:, range: '')
      ApplicationRecord.iex_intraday_chart(symbol, range)
    end

    def price(symbol:)
      ApplicationRecord.iex_price(symbol)
    end
  end
end
