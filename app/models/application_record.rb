# ApplicationRecord
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  @client = IEX::Api::Client.new(
    publishable_token: ENV['IEX_CLOUD_TOKEN'],
    secret_token: ENV['IEX_CLOUD_SECRET'],
    endpoint: ENV['IEX_CLOUD_URL']
  )

  def self.fetch_iex_batch_quote(symbols)
    iex_client.get(
      'stock/market/batch',
      symbols: symbols,
      types: 'quote',
      token: ENV['IEX_CLOUD_SECRET']
    )
  end

  def iex_quote
    quote = @client.quote(symbol)
    logo = { 'logo' => "https://storage.googleapis.com/iex/api/logos/#{symbol}.png" }
    logo.merge(quote)
  end

  def self.iex_quote(symbol)
    quote = iex_client.quote(symbol)
    logo = { 'logo' => "https://storage.googleapis.com/iex/api/logos/#{symbol}.png" }
    logo.merge(quote)
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

  def self.iex_client
    IEX::Api::Client.new(
      publishable_token: ENV['IEX_CLOUD_TOKEN'],
      secret_token: ENV['IEX_CLOUD_SECRET'],
      endpoint: ENV['IEX_CLOUD_URL']
    )
  end
end
