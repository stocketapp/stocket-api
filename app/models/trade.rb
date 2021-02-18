class Trade < ApplicationRecord
  belongs_to :user
  validates :symbol, presence: true
  validates :price, presence: true
  validates :quantity, presence: true
  validates :order_type, presence: true

  def self.get_trades(user)
    self.all
  end
end


# t.bigint "user_id"
#     t.string "symbol"
#     t.integer "quantity"
#     t.decimal "price"
#     t.decimal "total"
#     t.string "order_type"
#     t.date "order_date"
#     t.index ["user_id"], name: "index_trades_on
