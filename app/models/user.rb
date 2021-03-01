# User model
class User < ApplicationRecord
  has_many :trades
  has_many :shares
  has_many :balance_histories
  has_many :watchlists

  validates :email, presence: true, uniqueness: true
  validates :uid, presence: true, uniqueness: true

  # @return [Float]
  def calculate_portfolio_value
    new_arr = []
    portfolio = create_portfolio(Share.where(user_id: id))
    portfolio.each_pair do |k, v|
      share = Share.iex_price(k)
      new_arr.push(share * v)
    end
    (format '%.2f', new_arr.sum(0.00)).to_f
  end

  private

  # @param [ActiveRecord::Relation<Share>] positions
  # @return [Hash]
  def create_portfolio(positions)
    new_obj = {}
    positions.each do |p|
      new_obj.key?(p.symbol) ? new_obj[p.symbol] += p.size : new_obj[p.symbol] = p.size
    end
    new_obj
  end
end
