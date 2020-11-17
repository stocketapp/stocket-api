require 'json'

module Types
  class QueryType < Types::BaseObject
    field :get_user_info, Types::UserInfoType, null: false
    field :get_user, Types::UserType, null: false

    def get_user
      user = User.find_by! uid: context[:current_user]['uid']
      user
    end

    def get_user_info      
      UserInfo.find_by! id: context[:current_user]['id']
    end
  end
end
