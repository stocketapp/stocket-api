module Types
  # PortfolioType
  #
  class PortfolioPositions < Types::BaseObject
    field :symbol, String, null: false
    field :change, Float, null: false
    field :change_pct, Float, null: false
    field :logo, String, null: false
    field :size, Float, null: false
    field :company_name, String, null: false
  end

  # PortfolioType
  class PortfolioType < Types::BaseObject
    field :value, Float, null: true
    field :change, Float, null: true
    field :change_pct, Float, null: true
    field :positions, [Types::PositionType], null: true
    field :value_with_cash, Float, null: false

    def value
      calculate_portfolio_value
    end

    def value_with_cash
      value + user.cash
    end

    def change
      balance_history = BalanceHistory.where(user_id: user_id).order('id desc').limit(1)[0]
      print_f value: diff(value, balance_history.nil? ? 0 : balance_history[:value])
    end

    def change_pct
      print_f value: (change / value) * 100
    end

    def positions
      object[:symbols].map do |s|
        {
          symbol: s,
          shares: object[:shares].select { |el| el.user_id == user_id },
          quote: object[:quotes][s]['quote']
        }
      end
    end

    private

    # @return [Float]
    def calculate_portfolio_value
      new_arr = []
      portfolio = create_portfolio(shares)
      portfolio.each_pair { |k, v| new_arr.push(object[:quotes][k]['quote']['latestPrice'] * v) }
      (format '%.2f', new_arr.sum).to_f
    end

    # @param [ActiveRecord::Relation<Share>] positions
    # @return [Hash]
    def create_portfolio(positions)
      obj = {}
      positions.each { |p| obj.key?(p.symbol) ? obj[p.symbol] += p.size : obj[p.symbol] = p.size }
      obj
    end

    def user
      User.find_by id: user_id
    end

    def user_id
      object[:user_id]
    end

    def shares
      object[:shares]
    end
  end
end
