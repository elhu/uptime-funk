FactoryGirl.define do
  factory :outage do
    operator
    line "broken line"
    outage_type "total outage"
    cause "Because of reasons"
  end

end
