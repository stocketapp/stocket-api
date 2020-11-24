require 'json'

module Types
  class QueryType < Types::BaseObject
    field :get_user, Types::UserType, null: false, resolver_method: :fetch_user
    field :get_user_info, Types::UserInfoType, null: false, resolver_method: :fetch_user_info
    field :get_watchlist, [Types::WatchlistType], null: false, resolver_method: :fetch_watchlist

    def fetch_user
      User.find_by! uid: context[:current_user][:uid]
    end

    def fetch_user_info
      UserInfo.find_by! user_id: context[:current_user][:id]
    end

    def fetch_watchlist
      Watchlist.where(user_id: context[:current_user][:id])
    end
  end
end
