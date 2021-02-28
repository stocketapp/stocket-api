# Trade Model
class Trade < ApplicationRecord
  belongs_to :user
  validates :symbol, presence: true
  validates :price, presence: true
  validates :quantity, presence: true
  validates :order_type, presence: true
  validates :reference_id, presence: true, uniqueness: true
  validates :total, presence: true

  def buy
    Share.create!(share_obj) do
      user = User.find_by id: user_id
      new_value = user[:cash] - total

      User.update(user_id, cash: new_value)
    end
  end

  def sell
    share = retrieve_share

    if share.size <= quantity
      share.destroy!
    else
      share.update(size: share[:size] - quantity)
      User.update(user[:id], cash: user[:cash] + total)
    end
  end

  private

  def share_obj
    {
      user_id: user_id,
      symbol: symbol,
      price: price,
      trade_reference_id: reference_id,
      size: quantity,
      purchase_value: total
    }
  end

  def retrieve_share
    Share.find_by symbol: symbol, user_id: user_id
  end
end
