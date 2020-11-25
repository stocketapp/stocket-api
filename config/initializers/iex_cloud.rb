logger_instance = Logger.new(STDOUT)

IEX::Api.configure do |config|
  # config.logger.instance = logger_instance
  # config.logger.options = { bodies: true }
  # config.logger.proc = proc { |logger| logger.filter(/T?[sp]k_\w+/i, '[REMOVED]') }
end