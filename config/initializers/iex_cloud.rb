# logger_instance = Logger.new($stdout)

# IEX::Api.configure do |config|
#   config.logger.instance = logger_instance
#   config.logger.options = { bodies: true }
#   config.logger.proc = proc { |logger| logger.filter(/T?[sp]k_\w+/i, '[REMOVED]') }
# end

# IEX::Api.logger = logger_instance
