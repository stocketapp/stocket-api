set :output, 'log/cron.log'

every 1.hour do
  rake 'firebase:certificates:force_request'
end

every '15 16 * * 1-5', by_timezone: 'Eastern Time (US & Canada)' do
  rake 'balance_history:update_users'
end
