namespace :uptime_funk do
  desc 'Triggers jobs to fetch the reports for all operators'
  task fetch_all_reports: :environment do
    Operator.all.each do |operator|
      Fetcher.perform_async(operator.id)
    end
  end
end
