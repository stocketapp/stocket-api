class AddReferenceIdFieldToTrades < ActiveRecord::Migration[6.0]
  def change
    add_column :trades, :reference_id, :string, unique: true
  end
end
