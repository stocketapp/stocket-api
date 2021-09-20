# Create a portfolio value object
class Portfolio
  # @return [Float]
  def self.calculate_portfolio_value(user_id)
    shares = Share.where(user_id: user_id)
    shares.length.positive? ? value(shares) : 0.0
  end

  # @param [ActiveRecord::Relation<Share>] positions
  # @return [Hash]
  def self.create_portfolio(shares)
    obj = {}
    shares.each { |p| obj.key?(p.symbol) ? obj[p.symbol] += p.size : obj[p.symbol] = p.size }
    obj
  end

  def self.value(shares)
    new_arr = []
    portfolio = create_portfolio(shares)
    symbols = shares.map(&:symbol).uniq
    quotes = ApplicationRecord.fetch_iex_batch_quote(symbols.join(','))
    portfolio.each_pair { |k, v| new_arr.push(quotes[k]['quote']['latestPrice'] * v) }
    (format '%.2f', new_arr.sum).to_f
  end
end
