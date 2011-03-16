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
            print "\tt.#{field[:type]}, :#{field[:name]}"
            print ", :default => #{field[:default]}" if field[:default]
            print ", :null => false" if field[:not_null]
            print "\n"
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
