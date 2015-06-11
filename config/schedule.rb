set :output, 'log/cron.log'

every 5.minutes do
  rake "uptime_funk:fetch_all_reports "
end
