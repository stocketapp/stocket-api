module Types
  class PositionType < Types::BaseObject
    # field :symbol, String, null: false
    field :value, Float, null: false
    field :pct_change, Float, null: false
    field :change, Float, null: false
    field :avg_price, Float, null: false

    # @shares = Share.where symbol: symbol

    # def symbol
    #   'AMZN'
    # end

    # def pct_change()
    #   puts "Potision symbol: symbol"
    #   # puts "Shares: #{@shares}"
    # end
  end
end
