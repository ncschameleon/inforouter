module Inforouter #:nodoc
  class Document < Record
    # Document ID.
    attr_accessor :document_id
    # Document name.
    attr_accessor :name
    # Document path.
    attr_accessor :path
    # Document description.
    attr_accessor :description
    # Document creation date.
    attr_accessor :creation_date
    # Document modification date.
    attr_accessor :modification_date
    # Document checkout date.
    attr_accessor :checkout_date
    # Document checkout by.
    attr_accessor :checkout_by
    # Document checkout by user name.
    attr_accessor :checkout_by_user_name
    # Document size.
    attr_accessor :size
    # Document type.
    attr_accessor :type
    # Document percent complete.
    attr_accessor :percent_complete
    # Document retention date.
    attr_accessor :retention_date
    # Document disposition date.
    attr_accessor :disposition_date
    # Document doc type ID.
    attr_accessor :doc_type_id
    # Document doc type name.
    attr_accessor :doc_type_name
    # Document version number.
    attr_accessor :version_number

    # @return [Boolean]
    def exists?
      response = Inforouter.client.request :document_exists, path_params
      result = Inforouter::Responses::DocumentExists.parse response
      result[:@success] == 'true'
    end

    private

    # @return [Hash]
    def path_params
      { :path => path }
    end
  end
end
