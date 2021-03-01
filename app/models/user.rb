# User model
class User < ApplicationRecord
  has_many :trades
  has_many :shares
  has_many :balance_histories
  has_many :watchlists

  validates :email, presence: true, uniqueness: true
  validates :uid, presence: true, uniqueness: true

  # @param [ActiveRecord::Relation<Share>] positions
  # @return [Float]
  def calculate_portfolio_value(positions)
    new_arr = []
    portfolio = create_portfolio(positions)
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
      p.each_pair { |_, v| new_obj.key?(v) ? new_obj[v] += p.size : new_obj[p.symbol] = p.size }
    end
    new_obj
  end
end
