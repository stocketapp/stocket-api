module Types
  # PortfolioValueType
  class PortfolioValueType < Types::BaseObject
    field :value, Float, null: false
    # field :change, Float, null: false
    # field :change_pct, Float, null: false
  end
end
