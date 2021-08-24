Sentry.init do |config|
  config.dsn = 'https://0e632d3ccb63458f98b7e70784b7819c@o563230.ingest.sentry.io/5741924'
  config.breadcrumbs_logger = [:active_support_logger, :http_logger]

  # To activate performance monitoring, set one of these options.
  # We recommend adjusting the value in production:
  config.traces_sample_rate = 1.0
end
