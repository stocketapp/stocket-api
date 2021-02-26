module Types
  class IexChartType < Types::BaseObject
    field :high, Float, null: true
    field :low, Float, null: true
    field :open, Float, null: true
    field :close, Float, null: true
    field :symbol, String, null: false
    field :volume, GraphQL::Types::BigInt, null: true
    field :marketChangeOverTime, GraphQL::Types::BigInt, null: true
    field :changeOverTime, Int, null: true
    field :change, Float, null: true
    field :changePercent, Float, null: true
  end
end