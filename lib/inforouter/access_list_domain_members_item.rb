module Inforouter
  class AccessListDomainMembersItem < Record
    attr_accessor :right
    attr_accessor :description

    # Convert the object to a useable hash for SOAP requests.
    #
    # @return [Hash]
    def to_hash
      { :@Right => right }
    end
  end
end
