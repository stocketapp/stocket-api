class Share < ApplicationRecord
  belongs_to :user
  validates :symbol, presence: true
  validates :price, presence: true
  validates :trade_reference_id, presence: true
  validates :user_id, presence: true
  validates :size, presence: true
  validates :purchase_value, presence: true
end
