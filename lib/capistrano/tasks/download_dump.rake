# before 'db:download', 'db:ensure_directory_exists'

namespace :db do
  desc 'download production dump locally'
  task :download do
    on roles(:db) do
      stage = fetch(:stage)
      application = fetch(:application)
      db_config = YAML.load(capture(:cat, File.join(shared_path, 'config', 'database.yml')))[stage.to_s]
      file = "/tmp/#{application}_production.dump.#{Time.now.to_i}.sql.gz"
      with(:PGPASSWORD => "\"#{db_config['password']}\"") do
        execute(:pg_dump, "--clean --no-owner --no-privileges -U #{db_config['username']} -d #{db_config['database']} -h #{db_config['host']} | gzip > #{file}")
      end
      download! file, "tmp/backups"
    end
  end

  task :ensure_directory_exists do
    run_locally do
      execute(:mkdir, "-p tmp/backups")
    end
  end
end
