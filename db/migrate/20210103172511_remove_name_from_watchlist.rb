class RemoveNameFromWatchlist < ActiveRecord::Migration[6.0]
  def change
    remove_column :watchlists, :name, :string
  end
end
