module Inforouter #:nodoc
  class Document < Record
    # Document ID.
    attr_accessor :id
    # Document name.
    attr_accessor :name
    # Document path.
    attr_accessor :path
    # Document description.
    attr_accessor :description
    # Document update instructions.
    attr_accessor :update_instructions
    # Document creation date.
    attr_accessor :creation_date
    # Document modification date.
    attr_accessor :modification_date
    # Document checkout date.
    attr_accessor :checkout_date
    # Document checkout by username.
    attr_accessor :checkout_by_username
    # Document checkout by full name.
    attr_accessor :checkout_by_full_name
    # Document size.
    attr_accessor :size
    # Document type.
    attr_accessor :type
    # Document percent complete.
    attr_accessor :percent_complete
    # Document completion date.
    attr_accessor :completion_date
    # Document importance.
    attr_accessor :importance
    # Document retention date.
    attr_accessor :retention_date
    # Document disposition date.
    attr_accessor :disposition_date
    # Document expiration date.
    attr_accessor :expiration_date
    # Document register date.
    attr_accessor :register_date
    # Document registered by.
    attr_accessor :registered_by
    # Document doc type ID.
    attr_accessor :doc_type_id
    # Document doc type name.
    attr_accessor :doc_type_name
    # Document version.
    attr_accessor :version
    # Document published version.
    attr_accessor :published_version
    # Document type.
    attr_accessor :type

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
