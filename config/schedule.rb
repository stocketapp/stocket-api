set :output, 'log/cron.log'

every 1.hour do
  rake 'firebase:certificates:force_request'
end

every :day, at: '4:35pm', by_timezone: 'Eastern Time (US & Canada)' do
  rake 'balance_history:update_users'
end
