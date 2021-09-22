# ApplicationRecord
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def initialize(attributes = nil)
    @client = IEX::Api::Client.new(
      publishable_token: ENV['IEX_CLOUD_TOKEN'],
      secret_token: ENV['IEX_CLOUD_SECRET'],
      endpoint: ENV['IEX_CLOUD_URL']
    )
    super
  end

  def self.fetch_iex_batch_quote(symbols)
    iex_client.get(
      'stock/market/batch',
      symbols: symbols,
      types: 'quote',
      token: ENV['IEX_CLOUD_SECRET']
    )
  end

  def self.iex_batch_prices(symbols)
    iex_client.get(
      'stock/market/batch',
      symbols: symbols,
      types: 'price',
      token: ENV['IEX_CLOUD_SECRET']
    )
  end

  def self.iex_chart(symbol, range = '')
    iex_client.historical_prices(symbol, { range: range })
  end

  def iex_chart(symbol, range = '1d')
    @client.historical_prices(symbol, { range: range })
  end

  def iex_intraday_chart(symbol)
    @client.get(
      "stock/#{symbol}/intraday-prices",
      token: ENV['IEX_CLOUD_SECRET']
    )
  end

  def self.iex_intraday_chart(symbol)
    iex_client.get(
      "stock/#{symbol}/intraday-prices",
      token: ENV['IEX_CLOUD_SECRET']
    )
  end

  def iex_quote
    StocketMetric.start('#iex_quote')
    quote = @client.quote(symbol)
    logo = { 'logo' => "https://storage.googleapis.com/iex/api/logos/#{symbol}.png" }
    StocketMetric.end
    logo.merge(quote)
  end

  def self.iex_quote(symbol)
    StocketMetric.start('#iex_quote')
    quote = iex_client.quote(symbol)
    company_logo = { 'logo' => "https://storage.googleapis.com/iex/api/logos/#{symbol}.png" }
    StocketMetric.end
    company_logo.merge(quote)
  end

  def iex_price
    @client.price(symbol)
  end

  def self.iex_price(symbol)
    iex_client.price(symbol)
  end

  def self.iex_yesterday_price(symbol)
    iex_client.get("stock/#{symbol}/previous", token: ENV['IEX_CLOUD_SECRET'])['close']
  end

  def self.iex_news(symbol, range: 10)
    iex_client.get("stock/#{symbol}/news/last/#{range}", token: ENV['IEX_CLOUD_SECRET'])
  end

  def self.iex_company(symbol)
    company_logo = { 'logo' => logo(symbol) }
    company_logo.merge(iex_client.company(symbol))
  end

  def self.key_stats(symbol)
    iex_client.key_stats(symbol)
  end

  def self.list(list_type)
    quotes_list = iex_client.stock_market_list(list_type)
    quotes_list.map do |el|
      company_logo = { 'logo' => "https://storage.googleapis.com/iex/api/logos/#{el['symbol']}.png" }
      company_logo.merge(el)
    end
  end

  def self.iex_client
    IEX::Api::Client.new(
      publishable_token: ENV['IEX_CLOUD_KEY'],
      secret_token: ENV['IEX_CLOUD_SECRET'],
      endpoint: ENV['IEX_CLOUD_URL']
    )
  end

  def self.logo(symbol)
    iex_client.logo(symbol)
  end
end
