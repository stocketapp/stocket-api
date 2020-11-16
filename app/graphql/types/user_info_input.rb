module Types
  class UserInfoInput < BaseInputObject
    argument :cash, Int, required: true
    argument :portfolio_change, Float, required: true
    argument :portfolio_change_pct, Float, required: true
    argument :portfolio_value, String, required: true
    argument :apns_token, String, required: false
  end
end