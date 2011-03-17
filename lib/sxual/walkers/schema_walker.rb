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
              table_has_id = true
              next
            end

            s = "\tt.#{field[:type]}, :#{field[:name]}"
            s += ", :default => #{field[:default]}" if field[:default]
            s += ", :null => false" if field[:not_null]
            fields << s
          end
          force = table_has_id ? ":force => true, " : ''
          puts "create_table :#{table[:name]}, #{force} do |t|"
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
