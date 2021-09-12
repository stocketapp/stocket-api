class CreatePurchases < ActiveRecord::Migration[6.0]
  def change
    create_table :purchases do |t|
      t.string :sku
      t.decimal :price
      t.belongs_to :user, null: false, foreign_key: true
      t.string :purchase_id

      t.timestamps
    end
  end
end
