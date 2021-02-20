require 'securerandom'

module Mutations
  class CreateTrade < BaseMutation
    argument :symbol, String, "Stock symbol", required: true
    argument :price, Float, "Price per stock", required: true
    argument :quantity, Int, "Quantity of stocks user is buying", required: true
    argument :order_type, String, "Order type can be either 'BUY' or 'SELL'", required: true

    type Types::TradeType

    def resolve(symbol:, price:, quantity:, order_type:)
      trade = Trade.create!(
        user_id: context[:current_user][:id],
        symbol: symbol,
        price: price,
        quantity: quantity,
        order_type: order_type,
        total: calc_total(price, quantity),
        reference_id: SecureRandom.uuid
      )
      if trade.nil?
        raise GraphQL::ExecutionError, trade.errors.full_messages.join(", ")
      else
        pos = create_position(
          trade.user_id,
          trade.symbol,
          trade.price,
          trade.quantity,
          trade.reference_id
        )        
        trade
      end
    end

    private
    def calc_total(price, quantity)
      price * quantity
    end

    def create_position(user_id, symbol, price, quantity, reference_id)
      Position.create!(
        user_id: user_id,
        symbol: symbol,
        price: price,
        quantity: quantity,
        trade_reference_id: reference_id
      )
    end
  end
end