class Line < ActiveRecord::Base
  include OperatorSharding

  validates :operator_label, presence: true
  has_many :outages
end
