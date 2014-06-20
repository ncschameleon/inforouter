require 'nokogiri'

module Inforouter
  class FolderRule < Record
    attr_accessor :allowable_file_types
    attr_accessor :checkins
    attr_accessor :checkouts
    attr_accessor :document_deletes
    attr_accessor :folder_deletes
    attr_accessor :new_documents
    attr_accessor :new_folders
    attr_accessor :classified_documents

    def checkins?
      @checkins
    end

    def checkouts?
      @checkouts
    end

    def document_deletes?
      @document_deletes
    end

    def folder_deletes?
      @folder_deletes
    end

    def new_documents?
      @new_documents
    end

    def new_folders?
      @new_folders
    end

    def classified_documents?
      @classified_documents
    end

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
    def to_xml
      builder = Nokogiri::XML::Builder.new do |xml|
        xml.Rules do
          rule_item(xml, 'AllowableFileTypes', @allowable_file_types)
          rule_item(xml, 'Checkins', rule_value(@checkins))
          rule_item(xml, 'Checkouts', rule_value(@checkouts))
          rule_item(xml, 'DocumentDeletes', rule_value(@document_deletes))
          rule_item(xml, 'FolderDeletes', rule_value(@folder_deletes))
          rule_item(xml, 'NewDocuments', rule_value(@new_documents))
          rule_item(xml, 'NewFolders', rule_value(@new_folders))
          rule_item(xml, 'ClassifiedDocuments', rule_value(@classified_documents))
        end
      end
      builder.doc.root.to_xml
    end

    def rule_item(xml, name, value)
      xml.Rule(:Name => name, :Value => value)
    end

    def rule_value(value)
      value ? 'allows' : 'disallows'
    end
  end
end
