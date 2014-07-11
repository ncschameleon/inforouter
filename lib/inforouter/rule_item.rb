module Inforouter
  class RuleItem < Record
    # Rule item name.
    attr_accessor :name
    # Rule item value.
    attr_accessor :value

    # @return [Hash]
    def to_hash
      {
        :@Name => name,
        :@Value => value
      }
    end

    # @return [String]
    def value
      if !!@value == @value
        @value ? 'allows' : 'disallows'
      else
        @value
      end
    end
  end
end
