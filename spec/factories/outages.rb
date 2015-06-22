FactoryGirl.define do
  factory :outage do
    operator
    duration 1
    line "broken line"
    type "total outage"
    cause "Because of reasons"
  end

end
