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
    field :news, [Types::IexNewsType], null: false do
      argument :symbol, String, required: true
    end
    field :company, Types::CompanyType, null: false do
      argument :symbol, String, required: true
    end
    field :stats, Types::KeyStatsType, null: false do
      argument :symbol, String, required: true
    end
    field :balance, Types::BalanceType, null: false

    def user
      User.find_by! uid: context[:current_user][:uid]
    end

    def watchlist
      Watchlist.watchlist_prices(context[:current_user][:id])
    end

    def quote(symbol:)
      ApplicationRecord.iex_quote(symbol)
    end

    def position(symbol:)
      shares = Share.where symbol: symbol, user_id: context[:current_user][:id]
      quote = ApplicationRecord.iex_quote(symbol)
      { symbol: symbol, shares: shares, quote: quote }
    end

    def trades
      Trade.where user_id: context[:current_user][:id]
    end

    def balance_history
      BalanceHistory.where user_id: context[:current_user][:id]
    end

    def portfolio
      user_id = context[:current_user][:id]
      shares = Share.where user_id: user_id
      symbols = shares.map(&:symbol).uniq
      quotes = ApplicationRecord.fetch_iex_batch_quote(symbols.join(','))
      { user_id: user_id, shares: shares, quotes: quotes, symbols: symbols }
    end

    def chart(symbol:)
      ApplicationRecord.iex_chart(symbol)
    end

    def intraday(symbol:)
      ApplicationRecord.iex_intraday_chart(symbol)
    end

    def price(symbol:)
      ApplicationRecord.iex_price(symbol)
    end

    def news(symbol:)
      ApplicationRecord.iex_news(symbol)
    end

    def company(symbol:)
      ApplicationRecord.iex_company(symbol)
    end

    def stats(symbol:)
      ApplicationRecord.key_stats(symbol)
    end

    def balance
      user = User.find_by! uid: context[:current_user][:uid]
      { cash: user.cash }
    end
  end
end
