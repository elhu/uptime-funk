FactoryGirl.define do
  sequence :operator_name do |n|
    "Transport Company #{n}"
  end

  factory :operator do # well could you help me place this call ♬
    name { generate(:operator_name) }
    city 'Paris'
    content_type 'application/json'
    country 'France'
    report_url 'http://www.tfp.com/meteo/data'
    website 'example.org'
  end
end
