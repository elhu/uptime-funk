set :output, 'log/cron.log'

env 'PATH', "#{@ruby_path}:/usr/bin:/usr/local/bin:/bin"

every 5.minutes do
  rake "uptime_funk:fetch_all_reports "
end
