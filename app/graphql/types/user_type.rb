module Types
  # UserType
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :uid, String, null: false
    field :email, String, null: false
    field :display_name, String, null: true
    field :portfolio_value, Float, null: true
    field :cash, Int, null: false

    def display_name
      object[:displayName]
    end

    def cash
      object[:cash]
    end

    def email
      object[:email]
    end

    def uid
      object[:uid]
    end

    def id
      object[:id]
    end

    def portfolio_value
      user = User.find_by id: object[:id]
      user.calculate_portfolio_value
    end
  end
end
