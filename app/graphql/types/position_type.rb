module Types
  class PositionType < Types::BaseObject
    field :symbol, String, null: false
    field :value, Float, null: false
    field :change_pct, Float, null: false
    field :change, Float, null: false
    field :avg_price, Float, null: false
    # field :today_gains, Float, null: false
    # field :total_gains, Float, null: false

    def symbol
      object[:symbol]
    end

    def value
      calc_value(object[:latest_price])
    end

    def change
      (sprintf '%.2f', calc_change).to_f
    end

    def change_pct
      (sprintf '%.2f', (calc_change / calc_value(object[:latest_price])) * 100).to_f
    end

    def avg_price
      shares = object[:shares]
      (sprintf '%.2f', shares.map { |el| el['price'] }.sum(0.0) / shares.size).to_f
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
      (sprintf '%.2f', object[:shares].size * value).to_f
    end

    def yesterday_value
      object[:shares].size * object[:yesterday_price]
    end

    def calc_change
      calc_value(object[:latest_price]) - calc_value(object[:yesterday_price]).abs
    end
  end
end
