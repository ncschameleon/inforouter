module Inforouter #:nodoc:
  class PropertyRow < Record
    # Property row index.
    attr_accessor :row_nbr

    alias :row_number :row_nbr

    # @params params [Hash]
    def initialize(params = {})
      # Declare instance variables from params hash.
      params.each do |k, v|
        # Remove leading at.
        k = k.to_s.sub(/^@/, '')
        instance_variable_set("@#{k}", v)
        eigenclass = class << self; self; end
        eigenclass.class_eval do
          attr_accessor k
        end
      end
    end

    # @param xml [Nokogiri::XML::Builder]
    #
    # @return [Nokogiri::XML::Builder::NodeBuilder]
    def to_xml(xml)
      fields = {}
      instance_variables.each do |ivar|
        name = ivar.to_s.sub(/^@/, '')
        name == 'row_nbr' ? name = 'RowNbr' : name.upcase!
        fields[name] = instance_variable_get(ivar)
      end
      xml.propertyrow fields unless fields.empty?
    end
  end
end
