FactoryGirl.define do
  factory :weather_report do
    report({line_1: 'working as expected!'}.to_json)

    operator

    factory :full_report_with_outage do
      report File.read(Rails.root.join('spec', 'factories', 'ratp', 'with_alert.json'))
    end

    factory :full_report_without_outage do
      report File.read(Rails.root.join('spec', 'factories', 'ratp', 'without_alert.json'))
    end
  end
end
