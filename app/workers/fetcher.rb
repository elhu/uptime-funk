class Fetcher
  include Sidekiq::Worker

  def perform(operator_id)
    operator = Operator.find(operator_id).configure
    ReportFetcher.new(facade_for(operator)).fetch_and_store_report!
  end

  private
  def facade_for(operator)
    case operator.name
    when 'ratp'
      Ratp::Facade.new
    end
  end

end
