module Ratp
  class OutageProcessor
    attr_reader :report

    def initialize(report)
      @report = report
    end

    def process
      report.operator.configure
      report.report['status'].each do |line_type, data|
        data['lines'].each do |line_name, line_data|
          line_name = "#{data['name']} #{line_name}"
          process_line(line_name, line_data)
        end
      end
    end

    private
    def ongoing_outage_for(line)
      Outage.where(line: line, finished_at: nil).order(started_at: :desc).first
    end

    def process_line(line_name, data)
      ongoing_outage = ongoing_outage_for(line_name)
      line_state = data['name']
      line_broken = !(line_state.match(/^normal(_trav)?/))

      if line_broken && ongoing_outage.nil?
        outage_type = data['title']
        description = data['message']

        outage = Outage.create!(line: line_name, outage_type: outage_type, description: description, started_at: report.api_time)
        Rails.logger.info(outage.to_log_string('Creating'))
      elsif !line_broken && ongoing_outage
        ongoing_outage.close!(report.api_time)
        Rails.logger.info(ongoing_outage.to_log_string('Closing'))
      end
    end
  end
end
