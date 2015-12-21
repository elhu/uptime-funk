class Fetcher
  include Sidekiq::Worker

  def perform(operator_id)
    operator = Operator.find(operator_id).configure
    ReportFetcher.new(*params_for(operator)).fetch_and_store_report!
  end

  private
  def params_for(operator)
    case operator.name.downcase
    when 'ratp'
      [Ratp::Facade.new, Ratp::OutageProcessor]
    end
  end

end
