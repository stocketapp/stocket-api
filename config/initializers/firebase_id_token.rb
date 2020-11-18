FirebaseIdToken.configure do |config|
  is_dev = Rails.env.development?
  host = is_dev ? 'localhost' : 'stocket-api.redis.cache.windows.net'
  config.project_ids = ['stocket-dev', '']
  config.redis = Redis.new(host: host, port: 6380, db: 0)
end
