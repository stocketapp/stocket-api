require 'json'

module Types
  class QueryType < Types::BaseObject
    field :get_user, Types::UserType, null: false, resolver_method: :fetch_user
    field :get_user_info, Types::UserInfoType, null: false, resolver_method: :fetch_user_info
    field :watchlist, Types::WatchlistQuotesType, null: true, resolver_method: :fetch_watchlist
    field :get_quote, Types::IexQuoteType, null: false do
      argument :symbol, String, required: true
    end
    field :position, Types::PositionType, null: false, resolver_method: :position do
      argument :symbol, String, required: true
    end
    field :trades, [Types::TradeType], null: false, resolver_method: :get_trades

    def fetch_user
      User.find_by! uid: context[:current_user][:uid]
    end

    def fetch_user_info
      UserInfo.find_by! user_id: context[:current_user][:id]
    end

    def fetch_watchlist
      Watchlist.watchlist_prices(context[:current_user][:id])
    end

    def get_quote(symbol:)
      Watchlist.fetch_iex_quote(symbol)
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

    def get_trades
      Trade.where user_id: context[:current_user][:id]
    end
  end
end
