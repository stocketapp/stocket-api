module Types
  class TradeType < Types::BaseObject
    field :id, ID, null: false
    field :symbol, String, null: false
    field :price, Decimal, null: false
    field :quantity, Int, null: false
    field :total, Int, null: false
    field :order_date, Date, null: false
    field :order_type, String, null: false
  end
end