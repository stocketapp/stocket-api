class RenamePortfolioValueColumnOnUsers < ActiveRecord::Migration[6.0]
  def change
    rename_column :users, :potfolio_value, :portfolio_value
  end
end
