module Types
  # PositionType
  class PositionType < Types::BaseObject
    field :symbol, String, null: false
    field :total_value, Float, null: true
    field :change_pct, Float, null: true
    field :change, Float, null: true
    field :avg_price, Float, null: true
    field :position_size, Integer, null: true
    field :total_gains, Float, null: true

    def symbol
      object[:symbol]
    end

    def total_value
      calc_value(object[:latest_price])
    end

    def change
      calc_change
    end

    def change_pct
      print_f value: (calc_change / calc_value(object[:latest_price])) * 100
    end

    def avg_price
      shares = object[:shares]
      shares.map { |el| el['price'] }.sum(0.00) / shares.size
    end

    def position_size
      calc_shares_qtty
    end

    def total_gains
      print_f value: diff(calc_value(object[:latest_price]), object[:shares].map { |el| el['purchase_value'] }.sum)
    end

    private

    def diff(val1, val2)
      val1 - val2.abs
    end

    # Calculates the total value based on the price passed
    def calc_value(price)
      print_f value: calc_shares_qtty * price
    end

    # Returns the difference of the shares value between the original value at time of buying and current value
    def calc_change
      current_value = calc_value(object[:latest_price])
      prev_value = object[:shares].map(&:purchase_value).sum

      print_f value: diff(current_value, prev_value)
    end

    # Returns the amount of shares owned
    def calc_shares_qtty
      object[:shares].map(&:size).sum(0)
    end

    # Returns number formatted with two digits after decimal point
    def print_f(value:)
      (format '%.2f', value).to_f
    end
  end
end
