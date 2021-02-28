class AddPortfolioValueColumnToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :potfolio_value, :decimal
  end
end
