class RemoveQuantityFieldFromShares < ActiveRecord::Migration[6.0]
  def change
    remove_column :shares, :quantity, :integer
  end
end
