module Types
  # PositionType
  class PositionType < Types::BaseObject
    field :symbol, String, 'Stock symbol', null: false
    field :total_value, Float, 'Total value of the portfolio', null: true
    field :avg_price, Float, 'Average price at which the stock was purchased', null: true
    field :position_size, Integer, 'Amount of shares owned', null: true
    field :total_invested, Float, 'Total amount of money currently invested', null: false
    field :total_gains, Float, "Position's all time change", null: true
    field :total_gains_pct, Float, "Position's all time change %", null: true
    field :change_24h, Float, "Position's 24 hours change", null: true
    field :change_24h_pct, Float, "Position's 24 hours change %", null: true

    def symbol
      object[:symbol]
    end

    def total_value
      total_current_value
    end

    # Average price at which the stock was purchased
    def avg_price
      shares = object[:shares]
      shares.map { |el| el['price'] }.sum(0.00) / shares.size
    end

    # Return amount of shares owned
    def position_size
      size
    end

    # Return total amount of money currently invested
    def total_invested
      object[:shares].sum(&:purchase_value)
    end

    # Position's all time change
    def total_gains
      print_f value: diff(total_current_value, total_purchase_value)
    end

    # Position's all time change %
    def total_gains_pct
      calc_any_pct(total_purchase_value)
    end

    # Position's 24 hours change
    def change_24h
      calc_any_change(latest_price, previous_day_price, size)
    end

    # Position's 24 hours change %
    def change_24h_pct
      calc_any_pct(previous_day_price * size)
    end

    private

    # Return the change by comparing the previous price and the current price and multiplying by share size
    # @param [Float] price
    # @param [Float] prev_price
    # @param [Float] size
    def calc_any_change(price, prev_price, size)
      print_f value: diff(price * size, prev_price * size)
    end

    # Returns the change percentage based on given values
    def calc_any_pct(old_val)
      print_f value: ((total_current_value - old_val) / old_val) * 100
    end

    # Returns the latest price from the stock quote
    def latest_price
      object[:quote]['latest_price'] || object[:quote]['latestPrice']
    end

    # Returns the previous day closing price from the stock quote
    def previous_day_price
      object[:quote]['previous_close'] || object[:quote]['previousClose']
    end

    # Return the amount of shares owned for the queried stock
    def size
      object[:shares].map(&:size).sum(0)
    end

    # Return the total value of all owned shares based on current price
    def total_current_value
      latest_price * size
    end

    # Return the total value of all owned shares at purchase
    def total_purchase_value
      object[:shares].sum(&:purchase_value)
    end
  end
end
