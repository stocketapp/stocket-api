module Types
  class BalanceType < Types::BaseObject
    field :cash, Float, 'User cash balance', null: false
  end
end
