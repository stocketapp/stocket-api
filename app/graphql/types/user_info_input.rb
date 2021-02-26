module Types
  class UserInfoInput < BaseInputObject
    argument :cash, Int, required: true
    argument :apns_token, String, required: false
  end
end