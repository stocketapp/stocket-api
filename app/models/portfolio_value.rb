# Create a portfolio value object
class PortfolioValue
  attr_reader :value

  def initialize(user_id:)
    @user = User.find_by id: user_id
    @value = calc_value
  end

  def self.calculate(id:)
    user = User.find_by id: id
    value = user.calculate_portfolio_value
    { value: value }
  end

  def calc_value
    @user.calculate_portfolio_value
  end
end
