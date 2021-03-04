class CreateTrades < ActiveRecord::Migration[6.0]
  def change
    create_table :trades do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.string :symbol
      t.integer :size
      t.decimal :price, precision: 10, scale: 2
      t.decimal :total, precision: 10, scale: 2
      t.string :order_type

      t.timestamps
    end
  end
end
