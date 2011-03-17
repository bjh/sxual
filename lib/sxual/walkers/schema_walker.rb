module Sxual
  module Walkers
    class SchemaWalker < BaseWalker
      def initialize(data)
        @data = data
      end

      def walk
        @data.each do |table|          
          table_has_id = false

          fields = []
          
          table[:fields].each do |field|
            
            if field[:name].downcase == 'id'
              puts "ASSHOLE!!!!!!!"
              table_has_id = true
              next
            end

            puts "FUCK: #{field[:name]}"
              
            s = "\tt.#{field[:type]}, :#{field[:name]}"
            s += ", :default => #{field[:default]}" if field[:default]
            s += ", :null => false" if field[:not_null]
            fields << s
          end
          
          puts "create_table :#{table[:name]}, do |t|"
          puts fields.join("\n")
          puts "end"
          #puts "    CONSTRAINTS; #{table[:constraints]}"
          #puts "    FOREIGN KEYS: #{table[:fks]}"
          #puts "    INDEXES: #{table[:indexes]}"
        end
      end
    end
  end
end
