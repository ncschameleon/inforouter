module Inforouter
  class RuleItem < Record
    attr_accessor :name
    attr_accessor :value

    def to_hash
      {
        :Name => name,
        :Value => value
      }
    end

    def value
      if !!@value == @value
        @value ? 'allows' : 'disallows'
      else
        @value
      end
    end
  end
end
