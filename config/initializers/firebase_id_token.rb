FirebaseIdToken.configure do |config|
  is_dev = Rails.env.development?
  host = is_dev ? 'localhost' : 'redis-11326.c240.us-east-1-3.ec2.cloud.redislabs.com'
  config.project_ids = ['stocket-dev', '']
  config.redis = Redis.new(host: host, port: 11_326, db: 0)
end
