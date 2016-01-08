class ApplicationController < ActionController::Base
  before_action :set_operator

  private
  def set_operator
    Operator.where(name: 'RATP').first.configure
  end
end
