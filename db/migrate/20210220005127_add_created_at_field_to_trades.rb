class AddCreatedAtFieldToTrades < ActiveRecord::Migration[6.0]
  def change
    add_column :trades, :created_at, :datetime, null: false
  end
end
