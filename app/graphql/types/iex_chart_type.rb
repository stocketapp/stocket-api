module Types
  class IexChartType < Types::BaseObject
    field :high, Float, null: true
    field :low, Float, null: true
    field :open, Float, null: true
    field :close, Float, null: true
    field :symbol, String, null: false
    field :volume, GraphQL::Types::BigInt, null: true
    # field :market_change_over_time, GraphQL::Types::BigInt, null: true
    field :date, String, null: true
    field :label, String, null: true
    field :change, Float, null: true
    field :changeOverTime, Float, null: true
    # field :change_over_time_s, String, null: true
    field :change_percent, Float, null: true
    field :change_percent_s, String, null: true
    field :minute, String, null: true
  end
end
