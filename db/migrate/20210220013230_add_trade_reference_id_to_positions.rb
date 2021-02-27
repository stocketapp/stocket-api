class AddTradeReferenceIdToPositions < ActiveRecord::Migration[6.0]
  def change
    add_column :positions, :trade_reference_id, :string, null: false
  end
end
