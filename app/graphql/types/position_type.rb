module Types
  class PositionType < Types::BaseObject
    field :symbol, String, null: false
    field :value, Float, null: false
    field :change_pct, Float, null: false
    field :change, Float, null: false
    field :avg_price, Float, null: false
    field :position_size, Integer, null: false

    def symbol
      object[:symbol]
    end

    def value
      calc_value(object[:latest_price])
    end

    def change
      print_f value: calc_change
    end

    def change_pct
      print_f value: (calc_change / calc_value(object[:latest_price])) * 100
    end

    def avg_price
      shares = object[:shares]
      print_f value: shares.map { |el| el['price'] }.sum(0.00) / shares.size
    end

    def position_size
      calc_shares_qtty
    end

    # def today_gains
    #   shares = object[:shares]
    #   gains = diff(object[:today_change], object[:yesterday_change])

    #   sprintf "%.2f", gains
    # end

    # TODO: CALCULATE TOTAL GAINS BASED ON HISTORY
    # def total_gains
    #   res = object[:shares].map { |el| (object[:latest_price] - el['price']) / el['price'] }
    #   res.reduce(:+)
    # end

    private
    def diff(a, b)
      a - b.abs
    end
    
    def calc_value(value)
      print_f value: calc_shares_qtty * value
    end

    def yesterday_value
      object[:shares].size * object[:yesterday_price]
    end

    def calc_change
      calc_value(object[:latest_price]) - calc_value(object[:yesterday_price]).abs
    end

    def calc_shares_qtty
      object[:shares].map { |el| el.size }.sum(0)
    end

    def print_f(value:)
      (sprintf '%.2f', value).to_f
    end
  end
end
