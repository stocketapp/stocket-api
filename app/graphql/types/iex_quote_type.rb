module Types
  class IexQuoteType < Types::BaseObject
    field :symbol, String, null: false # stock ticker
    field :company_name, String, null: true # company name
    field :logo, String, null: true
    field :open, Float, null: true # official open price
    field :open_time, GraphQL::Types::BigInt, null: true # official listing exchange time for the open
    field :close, Float, null: true # official close price
    field :close_time, GraphQL::Types::BigInt, null: true # official listing exchange time for the close
    field :high, Float, null: true # market-wide highest price from the SIP, 15 minute delayed
    field :low, Float, null: true # market-wide lowest price from the SIP, 15 minute delayed
    field :latest_price, Float, null: true # latest price being the IEX real time price, the 15 minute delayed market price, or the previous close price
    field :iex_realtime_price, Float, null: true # last sale price of the stock on IEX
    field :change, Float, null: true # change in value, calculated using calculation_price from previous_close
    field :change_percent, Float, null: true # change in percent, calculated using calculation_price from previous_close
    field :market_cap, GraphQL::Types::BigInt, null: true # market cap, calculated in real time using calculation_price
    field :pe_ratio, Float, null: true # PE ratio, calculated in real time using calculation_price
    field :week_52_high, Float, null: true # adjusted 52 week high
    field :week_52_low, Float, null: true # adjusted 52 week low
    field :ytd_change, Float, null: true # price change percentage from start of year to previous close
    field :iex_volume, Integer, null: true
  end

  class IexQuoteAndNews < Types::BaseObject
    field :quote, Types::IexQuoteType, null: false
  end
end
