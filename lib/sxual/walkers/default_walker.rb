module Sxual
  module Walkers
    class DefaultWalker
      def initialize(data)
        @data = data
      end

      def print
        @data.each do |table|
          puts "table: #{table[:name]}"

          table[:fields].each do |field|
            puts "    FIELD: #{field}"
          end

          puts "    CONSTRAINTS; #{table[:constraints]}"
          puts "    FOREIGN KEYS: #{table[:fks]}"
          puts "    INDEXES: #{table[:indexes]}"
        end
      end
    end
  end
end