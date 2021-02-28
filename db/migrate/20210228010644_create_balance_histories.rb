class CreateBalanceHistories < ActiveRecord::Migration[6.0]
  def change
    create_table :balance_histories do |t|
      t.decimal :value, precision: 10, scale: 2
      t.decimal :change, precision: 10, scale: 2
      t.decimal :change_pct, precision: 10, scale: 2
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
