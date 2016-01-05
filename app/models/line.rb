class Line < ActiveRecord::Base
  include OperatorSharding

  validates :operator_label, presence: true
  has_many :outages
  has_one :ongoing_outage, -> { where(finished_at: nil) }, class_name: 'Outage'
end
