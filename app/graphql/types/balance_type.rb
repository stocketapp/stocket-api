module Types
  # BalanceType
  class BalanceType < Types::BaseObject
    field :cash, Float, 'User cash balance.', null: false
    field :portfolio, Float, 'User portfolio balance.', null: false
    field :total, Float, 'User total balance, cash and portoflio.', null: false

    def cash
      object[:user].cash
    end

    def portfolio
      Portfolio.calculate_portfolio_value(object[:user].id)
    end

    def total
      cash + portfolio
    end
  end
end
