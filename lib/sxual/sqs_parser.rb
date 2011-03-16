

module Sxual
  class SqsParser
    
    def parse(file)
      begin
        @xml = Nokogiri::XML(File.open(file))
        read()
      rescue => e
        puts "ERROR: #{e}"
      end
    end

    def read(  )
      tables = []
      @xml.xpath('SQLContainer/SQLTable').each do |table|
        puts '-' * 70
        puts "TABLE-NAME: " << table.xpath('name').text
        
        t = {
          :name => field.xpath('name').text,
          :contraints = parse_constraints(field),
          :indexes = parse_indexes(field),
          :fields = parse_fields(field)m
        }
      end
    end
    
  end
end
