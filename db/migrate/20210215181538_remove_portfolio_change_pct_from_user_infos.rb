class RemovePortfolioChangePctFromUserInfos < ActiveRecord::Migration[6.0]
  def change
    remove_column :user_infos, :portfolio_change_pct, :decimal
    remove_column :user_infos, :portfolio_change, :decimal
    remove_column :user_infos, :portfolio_value, :string
  end
end
