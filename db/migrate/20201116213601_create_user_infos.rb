class CreateUserInfos < ActiveRecord::Migration[6.0]
  def change
    create_table :user_infos do |t|
      t.belongs_to :user
      t.integer :cash
      t.decimal :portfolio_change_pct, precision: 10, scale: 2
      t.decimal :portfolio_change, precision: 10, scale: 2
      t.string :portfolio_value
      t.string :apns_token

      t.timestamps
    end
  end
end
