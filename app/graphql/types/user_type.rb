module Types
  class UserInfoType < Types::BaseObject
    field :cash, Bignum, null: false
    field :portfolio_change, Float, null: true
    field :portfolio_change_pct, Float, null: true
    field :portfolio_value, String, null: true
  end

  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :uid, String, null: false
    field :email, String, null: false
    field :displayName, String, null: false
    field :user_info, Types::UserInfoType, null: false

    def user_info
      UserInfo.find_by! user_id: context[:current_user][:uid]
    end
  end
end
