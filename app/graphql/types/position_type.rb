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
      object[:current_value]
    end

    def change
      sprintf '%.2f', calc_change
    end

    def change_pct
      sprintf '%.2f', (calc_change / object[:current_value]) * 100
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

    def calc_change
      object[:current_value] - object[:previous_value].abs
    end

    def cal_value
      (sprintf "%.2f", object[:shares].length * object[:latest_price]).to_f
    end
  end
end
