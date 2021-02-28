class CreateShares < ActiveRecord::Migration[6.0]
  def change
    create_table :shares do |t|
      t.belongs_to :user
      t.string :symbol
      t.decimal :price, precision: 2
      t.integer :size
      t.string :trade_reference_id
      t.decimal :purchase_value, precision: 2

      t.timestamps
    end
  end
end
