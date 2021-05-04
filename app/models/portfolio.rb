# Create a portfolio value object
class Portfolio
  attr_reader :value

  def initialize(user_id:)
    @user = User.find_by id: user_id
    @shares = Share.where user_id: user_id
    @balance_history = BalanceHistory.where(user_id: user_id).order('id desc').limit(1)[0]
    @value = calculate_portfolio_value(@shares)
    @shares_symbols = @shares.map(&:symbol)
    @shares_val = @shares.map { |el| { el.symbol => el.purchase_value } }
  end

  def change
    print_f value: diff(value, @balance_history.nil? ? 0 : @balance_history[:value])
  end

  def change_pct
    print_f value: (change / value) * 100
  end

  def positions
    return calc_positions unless @shares_symbols.empty?
  end

  # TODO: Add a value with total money invested

  private

  def calc_positions
    quotes = Share.fetch_iex_batch_quote(@shares_symbols.join(','))
    @shares_symbols.map do |sym|
      shares = Share.where(user_id: @user.id, symbol: sym)
      prev_value = shares.map(&:purchase_value).sum
      current_value = calc_value(shares, quotes[sym]['quote']['latestPrice'])
      p_change = calc_change(current_value, prev_value)
      logo = "https://storage.googleapis.com/iex/api/logos/#{sym}.png"
      { symbol: sym, change: p_change, change_pct: calc_change_pct(p_change, current_value), logo: logo }
    end
  end

  # Calculates the total value based on the price passed
  # @param [ActiveRecord::Relation<Share>] shares
  # @param [Float] price
  def calc_value(shares, price)
    print_f value: calc_shares_qtty(shares) * price
  end

  # Returns the difference between a share's original value at time of buying and current value
  # @param [Float] current_value
  # @param [Integer] prev_value
  def calc_change(current_value, prev_value)
    print_f value: diff(current_value, prev_value)
  end

  def calc_change_pct(p_change, p_value)
    print_f value: (p_change / p_value) * 100
  end

  # @return [Float]
  def calculate_portfolio_value(shares)
    new_arr = []
    portfolio = create_portfolio(shares)
    # TODO: calculate total value per symbol
    portfolio.each_pair { |k, v| new_arr.push(Share.iex_price(k) * v) }
    (format '%.2f', new_arr.sum).to_f
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

  def calc_shares_qtty(shares)
    puts shares
    shares.map(&:size).sum(0)
  end
end
