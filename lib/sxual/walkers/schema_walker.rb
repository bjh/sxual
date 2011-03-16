module Sxual
  module Walkers
    require 'walkers/base_walker'
    
    class SchemaWalker < BaseWalker
      def initialize(data)
        @data = data
      end
    end
  end
end
