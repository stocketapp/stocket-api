module Types
  class IexQuoteType < Types::BaseObject
    field :symbol, String, null: true # stock ticker
    field :companyName, String, null: true # company name
    # field :primary_exchange, null: true # primary listings exchange
    # field :sector # sector of the stock
    # field :calculation_price, null: true # source of the latest price - tops, sip, previousclose or close
    field :open, Float, null: true # official open price
    field :openTime, Int, null: true # official listing exchange time for the open
    field :close, Float, null: true # official close price
    field :closeTime, Int, null: true # official listing exchange time for the close
    field :high, Float, null: true # market-wide highest price from the SIP, 15 minute delayed
    field :low, Float, null: true # market-wide lowest price from the SIP, 15 minute delayed
    field :latestPrice, Float, null: true # latest price being the IEX real time price, the 15 minute delayed market price, or the previous close price
    # field :latest_source, null: true # the source of latestPrice - IEX real time price, 15 minute delayed price, Close or Previous close
    # field :latest_time, null: true # human readable time of the latestPrice
    # field :latest_update, null: true # the update time of latestPrice in milliseconds since midnight Jan 1, 1970
    # field :latest_update_t, null: true # latestUpdattrue with: ->(v) { v&.positive? ? Time.at(v / 1000) : nil } # the update time of latestPrice
    # field :latest_volume, null: true # the total market volume of the stock
    field :iexRealtimePrice, Float, null: true # last sale price of the stock on IEX
    # field :iex_realtime_size, null: true # last sale size of the stock on IEX
    # field :iex_last_updated, null: true # last update time of the data in milliseconds since midnight Jan 1, 1970 UTC or -1 or 0; if the value is -1 or 0, IEX has not quoted the symbol in the trading day
    # field :iex_last_updated_t, null: true #'iexLastUpdatetrue with: ->(v) { v&.positive? ? Time.at(v / 1000) : nil } # last update time of the data
    # field :delayed_price, null: true # 15 minute delayed market price
    # field :delayed_price_time, null: true # time of the delayed market price
    # field :extended_price, null: true # the pre market and post market price
    field :change, Float, null: true # change in value, calculated using calculation_price from previous_close
    field :changePercent, Float, null: true # change in percent, calculated using calculation_price from previous_close
    field :marketCap, Int, null: true # market cap, calculated in real time using calculation_price
    field :peRatio, Float, null: true # PE ratio, calculated in real time using calculation_price
    field :week52High, Float, null: true # adjusted 52 week high
    field :week52Low, Float, null: true # adjusted 52 week low
    field :ytdChange, Float, null: true # price change percentage from start of year to previous close
  end
end