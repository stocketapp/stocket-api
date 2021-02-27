class AddPurchaseValueColumnToShares < ActiveRecord::Migration[6.0]
  def change
    add_column :shares, :purchase_value, :float
  end
end
