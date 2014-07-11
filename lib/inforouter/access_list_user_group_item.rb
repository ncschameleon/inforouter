module Inforouter
  class AccessListUserGroupItem < Record
    attr_accessor :domain
    attr_accessor :name
    attr_accessor :right
    attr_accessor :description

    # Convert the object to a useable hash for SOAP requests.
    #
    # @return [Hash]
    def to_hash
      {
        :@Domain => domain,
        :@UserGroupName => name,
        :@Right => right
      }
    end
  end
end
