class CreateShares < ActiveRecord::Migration[6.0]
  def change
    create_table :shares do |t|
      t.belongs_to :user
      t.string :symbol
      t.decimal :price
      t.decimal :quantity
      t.string :trade_reference_id

      t.timestamps
    end
  end
end
