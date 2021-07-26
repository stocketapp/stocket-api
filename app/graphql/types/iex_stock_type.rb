module Types
  class IexStockType < Types::BaseObject
    field :quote, Types::IexQuoteType, null: false
    field :news, Types::IexNewsType, null: true
    field :chart, Types::IexChartType, null: true
  end
end
