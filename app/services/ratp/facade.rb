require 'uri'
require 'net/http'
require 'json'

module Ratp
  class Facade
    URL = "http://www.ratp.fr/meteo/ajax/data"

    def fetch_report
      uri = URI(URL)
      res = Net::HTTP.get_response(uri)
      raise FacadeError::RemoteHost.new(res.code) if res.code != '200'

      begin
        parsed_output = JSON.parse(res.body)
      rescue JSON::ParserError => e
        raise FacadeError::UnparseableOutput.new(e)
      end
    end
  end
end
