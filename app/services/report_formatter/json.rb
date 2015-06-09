module ReportFormatter
  class JSON
    def format(body)
      ::JSON.parse(body)
    end
  end
end
