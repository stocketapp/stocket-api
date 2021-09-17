FirebaseIdToken.configure do |config|
  password = ENV['REDIS_CACHE_PASSWORD']
  host = ENV['REDIS_CACHE_HOST']
  port = ENV['REDIS_CACHE_PORT']
  config.project_ids = %w[stocket-dev stocket-f0191]
  config.redis = Redis.new(host: host, port: port, db: 0, password: password)
end
