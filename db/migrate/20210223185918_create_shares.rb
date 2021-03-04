class CreateShares < ActiveRecord::Migration[6.0]
  def change
    create_table :shares do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.string :symbol
      t.decimal :price, precision: 10, scale: 2
      t.integer :size
      t.string :trade_reference_id, unique: true
      t.decimal :purchase_value, precision: 10, scale: 2

      t.timestamps
    end
  end
end
