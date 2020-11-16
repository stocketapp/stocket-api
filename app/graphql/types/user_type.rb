module Types
  class UserInfoType < Types::BaseObject
    field :cash, Bignum, null: false
    field :portfolio_change, Float, null: true
    field :portfolio_change_pct, Float, null: true
    field :portfolio_value, String, null: true
  end

  class UserType < Types::BaseObject
    field :id, ID, null: true
    field :uid, String, null: false
    field :email, String, null: true
    field :displayName, String, null: true
    field :userInfo, [UserInfoType], null: true
  end
end
