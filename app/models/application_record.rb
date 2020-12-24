class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  @@client = IEX::Api::Client.new(
    publishable_token: ENV['IEX_CLOUD_TOKEN'],
    secret_token: ENV['IEX_CLOUD_SECRET'],
    endpoint: ENV['IEX_CLOUD_URL'],
  )

  def self.fetch_iex_quote(symbols)
    @@client.get(
      'stock/market/batch',
      symbols: symbols,
      types: 'quote',
      token: ENV['IEX_CLOUD_SECRET']
    )
  end
end
