module FacadeError
  class BaseError < StandardError; end
  class RemoteHost < BaseError; end
  class UnparseableOutput < BaseError; end
end
