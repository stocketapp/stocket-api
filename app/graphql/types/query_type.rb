require 'json'

module Types
  class QueryType < Types::BaseObject
    field :get_user, Types::UserType, null: false, resolver_method: :fetch_user
    field :get_user_info, Types::UserInfoType, null: false, resolver_method: :fetch_user_info
    field :watchlist, Types::WatchlistQuotesType, null: false, resolver_method: :fetch_watchlist
    field :get_quote, Types::IexQuoteType, null: false do
      argument :symbol, String, required: true
    end
    field :position, Types::PositionType, null: false do
      argument :symbol, String, required: true
    end

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

    def position
      # {
      #   'symbol' => 'AMZN',
      #   'change' => 90.78,
      #   'value' => 100.90,
      #   'pct_change' => 2.78,
      #   'avg_price' => 23.7
      # }
    end
  end
end
