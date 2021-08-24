# Trade Model
class Trade < ApplicationRecord
  belongs_to :user
  validates :symbol, presence: true
  validates :price, presence: true
  validates :size, presence: true
  validates :order_type, presence: true
  validates :reference_id, presence: true, uniqueness: true
  validates :total, presence: true

  def buy
    Share.create!(share_obj) do
      if use[:cash] >= total
        user = User.find_by id: user_id
        new_value = user[:cash] + total

        User.update(user_id, cash: new_value)
      end
    end
  end

  def sell
    shares = retrieve_shares
    i = 0
    remaining = share_obj[:size]
    while remaining != 0
      current = shares[i]
      if current[:size] <= remaining
        current.destroy!
        remaining -= current[:size]
      elsif current[:size] > remaining
        current.update(size: current[:size] - remaining)
        remaining -= remaining
      end
      i += 1
    end
  end

  private

  def share_obj
    {
      user_id: user_id,
      symbol: symbol,
      price: price,
      trade_reference_id: reference_id,
      size: size,
      purchase_value: total
    }
  end

  def retrieve_shares
    Share.where symbol: symbol, user_id: user_id
  end
end
