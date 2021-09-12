# User model
class User < ApplicationRecord
  has_many :trades
  has_many :shares
  has_many :balance_histories
  has_many :watchlists
  has_many :purchases

  validates :email, presence: true, uniqueness: true
  validates :uid, presence: true, uniqueness: true

  # @return [Float]
  def calculate_portfolio_value
    new_arr = []
    portfolio = create_portfolio(shares)
    portfolio.each_pair { |k, v| new_arr.push(object[:quotes][k]['quote']['latestPrice'] * v) }
    (format '%.2f', new_arr.sum + :cash).to_f
  end

  private

  # @param [ActiveRecord::Relation<Share>] positions
  # @return [Hash]
  def create_portfolio(positions)
    obj = {}
    positions.each { |p| obj.key?(p.symbol) ? obj[p.symbol] += p.size : obj[p.symbol] = p.size }
    obj
  end
end
