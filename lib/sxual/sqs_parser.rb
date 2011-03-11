

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

    def read
      @xml.xpath('SQLContainer/SQLTable').each do |table|
        puts '-' * 70
        puts "TABLE-NAME: " << table.xpath('name').text
        
        table.xpath('SQLField').each do |field|
          puts "  " << field.xpath('name').text
        end
      end
    end
  end
end
