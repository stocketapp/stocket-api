FirebaseIdToken.configure do |config|
  is_dev = Rails.env.development?
  host = is_dev ? 'localhost' : ENV['REDIS_CACHE_HOST']
  port = is_dev ? 6379 : ENV['REDIS_CACHE_PORT']
  password = ENV['REDIS_CACHE_PASSWORD']
  puts host
  puts port
  puts password
  config.project_ids = ['stocket-dev', '']
  config.redis = if is_dev
                   Redis.new(host: host, port: port, db: 0, password: password)
                 else
                   Redis.new(host: host, port: port, db: 0)

                 end
end
