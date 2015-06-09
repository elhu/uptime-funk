FactoryGirl.define do
  factory :weather_report do
    report({line_1: 'working as expected!'}.to_json)

    operator
  end
end
