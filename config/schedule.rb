set :output, 'log/cron.log'

job_type :rbenv_rake, %Q{export PATH=$HOME/.rbenv/shims:$HOME/.rbenv/bin:/usr/bin:$PATH; eval "$(rbenv init -)"; \
                         cd :path && bundle exec rake :task --silent :output }

env 'RAILS_ENV', 'production'

every 5.minutes do
  # rbenv_rake "uptime_funk:fetch_all_reports "
end
