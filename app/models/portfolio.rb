# Create a portfolio value object
class Portfolio
  def initialize(user_id:)
    @user = User.find_by id: user_id
    @shares = Share.where user_id: user_id
    @balance_history = BalanceHistory.where(user_id: user_id).order('id desc').limit(1)[0]
    @value = calculate_portfolio_value(@shares)
  end

  def value
    @value
  end

  def change
    print_f value: diff(value, @balance_history.nil? ? 0 : @balance_history[:value])
  end

  def change_pct
    print_f value: (change / value) * 100
  end

  private

  # @return [Float]
  def calculate_portfolio_value(shares)
    new_arr = []
    portfolio = create_portfolio(shares)
    portfolio.each_pair { |k, v| new_arr.push(Share.iex_price(k) * v) }
    (format '%.2f', new_arr.sum(0.00)).to_f
  end

  # @param [ActiveRecord::Relation<Share>] positions
  # @return [Hash]
  def create_portfolio(positions)
    obj = {}
    positions.each { |p| obj.key?(p.symbol) ? obj[p.symbol] += p.size : obj[p.symbol] = p.size }
    obj
  end

  # Returns number formatted with two digits after decimal point
  def print_f(value:)
    (format '%.2f', value).to_f
  end

  def diff(a, b)
    a - b.abs
  end

  def calc_shares_qtty
    @shares.map(&:size).sum(0)
  end
end
