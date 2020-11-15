class CreateTrades < ActiveRecord::Migration[6.0]
  def change
    create_table :trades do |t|
      t.string :action

      t.timestamps
    end
  end
end
