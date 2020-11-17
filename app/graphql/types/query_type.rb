require 'json'

module Types
  class QueryType < Types::BaseObject
    field :get_user_info, Types::UserInfoType, null: false

    def get_user_info      
      UserInfo.find_by! id: context[:current_user]['id'].inspect
    end
  end
end
