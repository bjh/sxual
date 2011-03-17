module Sxual
  module Walkers
    class SchemaWalker < BaseWalker
      def initialize(data)
        @data = data
      end

      def walk
        @data.each do |table|
          
          
          table_has_id = false
          
          fields = table[:fields].map do |field|
                        
            if field[:name].downcase == 'id'
              table_has_id = true
            else
              
              s = "\tt.#{field[:type]}, :#{field[:name]}"
              s << ", :default => #{field[:default]}" if field[:default]
              s << ", :null => false" if field[:not_null]
              return s
            end
          end
          
          puts "create_table :#{table[:name]}, do |t|"
          puts s.join("\n")
          puts "end"
          #puts "    CONSTRAINTS; #{table[:constraints]}"
          #puts "    FOREIGN KEYS: #{table[:fks]}"
          #puts "    INDEXES: #{table[:indexes]}"
        end
      end
    end
  end
end
