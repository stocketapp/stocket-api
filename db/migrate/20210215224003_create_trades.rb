class CreateTrades < ActiveRecord::Migration[6.0]
  def change
    create_table :trades do |t|
      t.belongs_to :user
      t.string :symbol
      t.integer :quantity
      t.decimal :price
      t.decimal :total
      t.string :order_type
      t.date :order_date
    end
  end
end
