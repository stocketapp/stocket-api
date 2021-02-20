class CreatePositions < ActiveRecord::Migration[6.0]
  def change
    create_table :positions do |t|
      t.belongs_to :user
      t.string :symbol
      t.decimal :price
      t.decimal :quantity

      t.timestamps
    end
  end
end
