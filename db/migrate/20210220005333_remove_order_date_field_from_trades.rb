class RemoveOrderDateFieldFromTrades < ActiveRecord::Migration[6.0]
  def change
    remove_column :trades, :order_date, :date
  end
end
