FirebaseIdToken.configure do |config|
  config.project_ids = ['stocket-dev', '']
  config.redis = Redis.new(host: 'localhost', port: 6379, db: 15)
end