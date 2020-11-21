FirebaseIdToken.configure do |config|
  is_dev = Rails.env.development?
  password = is_dev ? 'password' : ENV['REDIS_CACHE_PASSWORD']
  config.project_ids = ['stocket-dev', '']
  config.redis = Redis.new(host: ENV['REDIS_CACHE_HOST'], port: 15680, db: 0, password: password)
end
