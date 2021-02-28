class CreateWatchlists < ActiveRecord::Migration[6.0]
  def change
    create_table :watchlists do |t|
      t.string :symbol
      t.belongs_to :user

      t.timestamps
    end
  end
end
