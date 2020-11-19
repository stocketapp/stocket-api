require 'json'

module Types
  class QueryType < Types::BaseObject
    field :get_user_info, Types::UserInfoType, null: false, method: :fetch_user
    field :get_user, Types::UserType, null: false, method: :fetch_user_info

    def fetch_user
      User.find_by! uid: context[:current_user]['uid']
    end

    def fetch_user_info
      UserInfo.find_by! id: context[:current_user]['id']
    end
  end
end
