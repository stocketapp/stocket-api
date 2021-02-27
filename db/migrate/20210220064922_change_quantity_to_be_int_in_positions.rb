class ChangeQuantityToBeIntInPositions < ActiveRecord::Migration[6.0]
  def change
    change_column :positions, :quantity, :int
  end
end
