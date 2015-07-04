module Inforouter #:nodoc:
  class PropertySet < Record
    # Property set name.
    attr_accessor :name
    # Array of <tt>Inforouter::PropertyRow</tt>s.
    attr_accessor :rows

    def initialize(params = {})
      params = { rows: [] }.merge(params)
      super params
    end

    # <Propertysets>
    #   <propertyset Name="LETTER">
    #     <propertyrow RowNbr="1" LetterType="Business" Subject="Subject 1 - updated subject Lorem dolor sit amet.."/>
    #     <propertyrow RowNbr="2" LetterType="Business" Subject="Subject 2 - updated subject ..Lorem Dolor Sit amet.."/>
    #   </propertyset>
    # </Propertysets>
    #
    # @return [String]
    def self.to_xml(property_sets)
      builder = Nokogiri::XML::Builder.new do |xml|
        xml.Propertysets do
          property_sets.each do |property_set|
            xml.propertyset(Name: property_set.name) do
              property_set.rows.each { |row| row.to_xml(xml) }
            end
          end
        end
      end
      builder.doc.root.to_xml
    end

    # <Propertysets>
    #   <propertyset Name="LETTER">
    #     <propertyrow RowNbr="1"/>
    #     <propertyrow RowNbr="3"/>
    #   </propertyset>
    # </Propertysets>
    #
    # @return [String]
    def delete_xml
      builder = Nokogiri::XML::Builder.new do |xml|
        xml.Propertysets do
          xml.propertyset(Name: @name) do
            @rows.each do |row|
              xml.propertyrow(RowNbr: row.row_number)
            end
          end
        end
      end
      builder.doc.root.to_xml
    end
  end
end
