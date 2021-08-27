require 'securerandom'

module Mutations
  # CreateTrade
  class CreateTrade < BaseMutation
    argument :symbol, String, 'Stock symbol', required: true
    argument :price, Float, 'Price per stock', required: true
    argument :size, Float, 'Quantity of stocks user is buying', required: true
    argument :order_type, String, 'Order type can be either "BUY" or "SELL"', required: true

    type Types::TradeType

    def resolve(symbol:, price:, size:, order_type:)
      obj = {
        user_id: context[:current_user][:id],
        symbol: symbol,
        price: price,
        size: size,
        order_type: order_type,
        total: calc_total(price, size),
        reference_id: SecureRandom.uuid
      }
      create_trade(obj)
    end

    private

    def calc_total(price, size)
      price * size
    end

    def create_trade(trade)
      Trade.create!(trade) do |t|
        if t.nil?
          handle_error(t)
        else
          t.order_type == 'BUY' ? t.buy : t.sell
        end
      end
    end
  end
end
