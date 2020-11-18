FirebaseIdToken.configure do |config|
  is_dev = Rails.env.development?
  host = is_dev ? 'localhost' : ENV['REDIS_CACHE_HOST']
  port = is_dev ? 6379 : ENV['REDIS_CACHE_PORT']
  password = is_dev ? '' : ENV['REDIS_CACHE_PASSWORD']
  config.project_ids = ['stocket-dev', '']
  config.redis = Redis.new(host: host, port: port, db: 0, password: password)
end
