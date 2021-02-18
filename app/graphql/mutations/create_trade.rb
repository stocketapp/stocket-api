module Mutations
  class CreateTrade < BaseMutation
    argument :symbol, String, required: true
    argument :price, Decimal, required: true
    argument :quantity, Int, required: true
    argument :order_type, String, required: true

    Types::TradeType, null: false
  end
end