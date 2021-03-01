module Types
  # BalanceHistoryType -> represents a single row in the BalanceHistory table
  class BalanceHistoryType < Types::BaseObject
    field :id, ID, null: false
    field :value, Float, null: false
    field :change, Float, null: false
    field :change_pct, Float, null: false
    field :created_at, String, null: false, resolver_method: :created_at

    def created_at
      object['created_at'].strftime '%b %d, %Y'
    end
  end
end
