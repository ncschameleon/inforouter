module Inforouter #:nodoc:
  class PropertyRow < Record
    # Property row index.
    attr_accessor :index

    def initialize(params = {})
      params = { index: 0 }.merge(params)
      super params
    end
  end
end
