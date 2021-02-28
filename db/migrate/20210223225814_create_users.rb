class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :uid, null: false
      t.string :email, null: false, unique: true
      t.string :displayName
      t.decimal :cash
      t.decimal :apns_token
      t.decimal :portfolio_value, precision: 2

      t.timestamps
    end
  end
end
