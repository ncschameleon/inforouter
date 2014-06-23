module Inforouter
  class Rules
    # Array of <tt>Inforouter::RuleItem</tt>s.
    attr_accessor :rules

    def initialize(params = {})
      params = {
        :allowable_file_types => '',
        :checkins => false,
        :checkouts => false,
        :document_deletes => false,
        :folder_deletes => false,
        :new_documents => false,
        :new_folders => false,
        :classified_documents => false
      }.merge(params)
      @rules = []
      params.each do |key, value|
        @rules << Inforouter::RuleItem.new(
          :name => key.to_s.camelize,
          :value => value
        )
      end
    end

    # The Rules XML fragment should be as described below.
    # The Rule item that is not specified in the xml structure will not be
    # updated.
    # For the AllowableFileTypes set value attribute to comman delimited file
    # extensions or set value to "*" for allowing all file types.
    #
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
          rules.each { |rule| xml.Rules(rule.to_hash) }
        end
      end
      builder.doc.root.to_xml
    end
  end
end
