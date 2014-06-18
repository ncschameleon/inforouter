module Inforouter #:nodoc:
  # A generic infoRouter record.
  class Record
    # Initialize the record.
    #
    # @param attrs [Hash] Attributes defined for this record.
    def initialize(attrs = {})
      attrs.each do |sym, val|
        send "#{sym}=", val
      end
    end
  end
end
