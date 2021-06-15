# Create a portfolio value object
class Portfolio
  attr_reader :value

  def initialize(user_id:)
    @user = User.find_by id: user_id
    @shares = Share.where user_id: user_id
    @value = calculate_portfolio_value(@shares)
  end

  def change
    balance_history = BalanceHistory.where(user_id: @user.id).order('id desc').limit(1)[0]
    print_f value: diff(@value, balance_history.nil? ? 0 : balance_history[:value])
  end

  def change_pct
    print_f value: (change / @value) * 100
  end

  def positions
    return calc_positions unless @shares.map(&:symbol).empty?
  end

  # TODO: Add a value with total money invested

  private

  def calc_change_with_price(purchase_price, size, latest_price)
    purchase_value = purchase_price * size
    current_value = latest_price * size
    calc_change(current_value, purchase_value)
  end

  def calc_change_and_pct(share, latest_price)
    sum_change = calc_change_with_price(share.price, share.size, latest_price)
    pct = calc_change_pct(sum_change, latest_price * share.size)
    { change: sum_change, pct: pct }
  end

  def define_position(sym, quotes)
    latest_price = quotes[sym]['quote']['latestPrice']
    name = quotes[sym]['quote']['companyName']
    pos = Share.where(user_id: 3, symbol: sym).map { |sh| calc_change_and_pct(sh, latest_price) }
    change = pos.sum { |i| i[:change] }
    pct = pos.sum { |i| i[:pct] }
    { symbol: sym, change: change, change_pct: pct, logo: logo(sym), company_name: name }
  end

  def calc_positions
    shares_symbols = @shares.map(&:symbol)
    quotes = Share.fetch_iex_batch_quote(shares_symbols.uniq.join(','))
    shares_symbols.uniq.map { |sym| define_position(sym, quotes) }
  end

  def logo(symbol)
    "https://storage.googleapis.com/iex/api/logos/#{symbol}.png"
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
    shares.map(&:size).sum(0)
  end
end
