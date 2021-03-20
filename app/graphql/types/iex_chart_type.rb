module Types
  class IexChartType < Types::BaseObject
    field :high, Float, null: true
    field :low, Float, null: true
    field :open, Float, null: true
    field :close, Float, null: true
    field :symbol, String, null: false
    field :volume, GraphQL::Types::BigInt, null: true
    field :market_change_over_time, GraphQL::Types::BigInt, null: true
    field :change_over_time, Int, null: true
    field :change, Float, null: true
    field :change_percent, Float, null: true
    field :date, String, null: false
    field :label, String, null: false
  end
end