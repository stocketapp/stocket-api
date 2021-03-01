module Types
  # UserType
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :uid, String, null: false
    field :email, String, null: false
    field :displayName, String, null: false
    field :portfolio_value, Float, null: false

    def portfolio_value
      user = User.find_by id: object[:id]
      user.calculate_portfolio_value(Share.where(user_id: user.id))
    end
  end
end
