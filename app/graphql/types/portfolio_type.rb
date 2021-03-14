module Types
  # PortfolioType
  #
  class PortfolioPositions < Types::BaseObject
    field :symbol, String, null: false
    field :change, Float, null: false
    field :change_pct, Float, null: false
    field :logo, String, null: false
  end

  class PortfolioType < Types::BaseObject
    field :value, Float, null: false
    field :change, Float, null: false
    field :change_pct, Float, null: false
    field :positions, [PortfolioPositions], null: false
  end
end
