module OperatorSharding
  extend ActiveSupport::Concern

  included do
    belongs_to :operator

    before_validation :set_operator
    validates_presence_of :operator
  end

  private
  def set_operator
    self.operator ||= Operator.current
  end
end
