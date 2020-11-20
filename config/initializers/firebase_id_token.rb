FirebaseIdToken.configure do |config|
  is_dev = Rails.env.development?
  host = is_dev ? 'localhost' : ENV['REDIS_CACHE_HOST']
  port = is_dev ? 6379 : ENV['REDIS_CACHE_PORT']
  password = ENV['REDIS_CACHE_PASSWORD']
  config.project_ids = ['stocket-dev', '']
  redis_dev = Redis.new(host: host, port: port, db: 0)
  redis_prod = Redis.new(host: host, port: port, db: 0, password: password)
  config.redis = is_dev ? redois_dev : redis_prod
end
