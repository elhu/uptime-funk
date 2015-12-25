FactoryGirl.define do
  factory :outage do
    operator
    line
    outage_type "total outage"
    cause "Because of reasons"
  end

end
