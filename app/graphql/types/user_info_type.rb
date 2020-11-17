module Types
  class UserInfoType < Types::BaseObject
    field :cash, Int, null: false
    field :portfolio_change, Float, null: false
    field :portfolio_change_pct, Float, null: false
    field :portfolio_value, String, null: false
    field :apns_token, String, null: false
  end
end