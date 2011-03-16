module Sxual
  module Walkers
    class SchemaWalker < BaseWalker
      def initialize(data)
        @data = data
      end

      def walk
        @data.each do |table|
          puts "create_table :#{table[:name]}, do |t|"

          table[:fields].each do |field|
            puts "t.[type], :#{field[:name]}"
          end

          puts "end"
          #puts "    CONSTRAINTS; #{table[:constraints]}"
          #puts "    FOREIGN KEYS: #{table[:fks]}"
          #puts "    INDEXES: #{table[:indexes]}"
        end
      end
    end
  end
end
