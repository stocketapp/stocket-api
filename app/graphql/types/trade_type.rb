module Types
  class TradeType < Types::BaseObject
    field :id, ID, "Order ID", null: true
    field :symbol, String, "Stock symbol", null: false
    field :price, Float, "Price per stock", null: false
    field :quantity, Int, "Quantity of stocks purchased", null: false
    field :total, Float, "Order total", null: false
    field :order_type, String, "Order type can be either 'BUY' or 'SELL'", null: false
    field :reference_id, String, "Order reference ID", null: false
    field :user_id, Int, "User that made the trade", null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, "Date the order was placed", null: false
  end
end