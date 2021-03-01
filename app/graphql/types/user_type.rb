module Types
  # UserType
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :uid, String, null: false
    field :email, String, null: false
    field :displayName, String, null: false
    field :portfolio_value, Float, null: false

    def portfolio_value
      user = User.find_by id: context[:current_user][:id]
      positions = Share.where user_id: user.id
      portfolio = user.create_portfolio(positions)
      user.calculate_portfolio_value(portfolio)
    end
  end
end
