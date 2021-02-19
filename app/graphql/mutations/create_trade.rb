require 'securerandom'

module Mutations
  class CreateTrade < BaseMutation
    argument :symbol, String, "Stock symbol", required: true
    argument :price, Float, "Price per stock", required: true
    argument :quantity, Int, "Quantity of stocks user is buying", required: true
    argument :order_type, String, "Order type can be either 'BUY' or 'SELL'", required: true
    argument :uid, Int, "[OPTIONAL] Pass the user ID", required: false

    type Types::TradeType

    def resolve(symbol:, price:, quantity:, order_type:, uid: nil)
      Trade.create(
        user_id: context[:current_user][:id],
        symbol: symbol,
        price: price,
        quantity: quantity,
        order_type: order_type,
        total: calc_total(price, quantity),
        order_date: DateTime.now,
        reference_id: SecureRandom.uuid
      )
    end

    private
    def calc_total(price, quantity)
      price * quantity
    end
  end
end