class AddSizeFieldToShares < ActiveRecord::Migration[6.0]
  def change
    add_column :shares, :size, :integer
  end
end
