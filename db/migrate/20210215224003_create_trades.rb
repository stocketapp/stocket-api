class CreateTrades < ActiveRecord::Migration[6.0]
  def change
    create_table :trades do |t|
      t.belongs_to :user
      t.string :symbol
      t.integer :quantity
      t.decimal :price, precision: 2
      t.decimal :total, precision: 2
      t.string :order_type

      t.timestamps
    end
  end
end
