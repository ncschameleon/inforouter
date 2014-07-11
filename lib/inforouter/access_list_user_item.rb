module Inforouter
  class AccessListUserItem < Record
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
        :@UserName => name,
        :@Right => right
      }
    end
  end
end
