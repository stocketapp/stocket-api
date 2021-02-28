class CreateBalanceHistory < ActiveRecord::Migration[6.0]
  def change
    create_table :balance_histories do |t|
      t.decimal :value
      t.decimal :change
      t.decimal :change_pct

      t.timestamps
    end
  end
end
