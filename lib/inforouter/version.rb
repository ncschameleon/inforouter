module Inforouter
  class Version
    MAJOR = 0
    MINOR = 2
    PATCH = 3
    PRE = nil

    class << self
      # @return [String]
      def to_s
        [MAJOR, MINOR, PATCH, PRE].compact.join('.')
      end
    end
  end
end
