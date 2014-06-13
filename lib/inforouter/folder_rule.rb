require 'nokogiri'

module Inforouter
  class FolderRule
    # The Rules XML fragment should be as described below.
    # The Rule item that is not specified in the xml structure will not be
    # updated.
    # For the AllowableFileTypes set value attribute to comman delimited file
    # extensions or set value to "*" for allowing all file types.
    # <Rules>
    #   <Rule Name="AllowableFileTypes" Value="BMP,DOC,JPG,XLS" />
    #   <Rule Name="Checkins" Value="disallows" />
    #   <Rule Name="Checkouts" Value="disallows" />
    #   <Rule Name="DocumentDeletes" Value="disallows" />
    #   <Rule Name="FolderDeletes" Value="disallows" />
    #   <Rule Name="NewDocuments" Value="disallows" />
    #   <Rule Name="NewFolders" Value="disallows" />
    #   <Rule Name="ClassifiedDocuments" Value="allows" />
    # </Rules>
    def self.rules_xml(options = {})
      options = {
        :allowable_file_types => nil,
        :checkins => 'disallows',
        :checkouts => 'disallows',
        :document_deletes => 'disallows',
        :folder_deletes => 'disallows',
        :new_documents => 'disallows',
        :new_folders => 'disallows',
        :classified_documents => 'disallows'
      }.merge(options)
      builder = Nokogiri::XML::Builder.new do |xml|
        xml.Rules do
          rule_item(xml, 'AllowableFileTypes', options[:allowable_file_types])
          rule_item(xml, 'Checkins', options[:checkins])
          rule_item(xml, 'Checkouts', options[:checkouts])
          rule_item(xml, 'DocumentDeletes', options[:document_deletes])
          rule_item(xml, 'FolderDeletes', options[:folder_deletes])
          rule_item(xml, 'NewDocuments', options[:new_documents])
          rule_item(xml, 'NewFolders', options[:new_folders])
          rule_item(xml, 'ClassifiedDocuments', options[:classified_documents])
        end
      end
      builder.doc.root.to_xml
    end

    def self.rule_item(xml, name, value)
      xml.Rule(:Name => name, :Value => value)
    end
  end
end
