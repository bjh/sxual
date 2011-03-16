
module Sxual
  class SqsParser
    
    def parse(file)
      begin
        @xml = Nokogiri::XML(File.open(file))
        read()
      rescue => e
        puts "SqsParser::parse: #{e}"
      end
    end

    def read()
      @xml.xpath('SQLContainer/SQLTable').each do |table|
        puts '-' * 70
        puts "TABLE-NAME: " << table.xpath('name').text

        t = {
          :name => table.xpath('name').text,
          #:contraints => constraints(table),
          #:indexes => indexes(table),
          :fields => fields(table),
        }

        #block.call(t)
      end
    end
    
    def constraints(table)
      table.xpath('SQLConstraint').collect do |field|
        {
          :name => field.xpath('name').text,
          :fieldNames => field.xpath('fieldName').map { |f| f.text },
          :indexType => field.xpath('indexType').text,
        }
      end
    end
    
    def fields(table)
      sql_fields =[]
      table.xpath('SQLField').each do |field|
        f = {
          :name => field.xpath('name').text,
          :type => field.xpath('type').text,
          :notNull => field.xpath('notNull').text == "1",
          # this may have mutliple fields, and would be getting squashed
          :referencesField => field.xpath('referencesField').first,
          :referencesTable => field.xpath('referencesTable').first.text,
          
          # todo: check for data type lengths
          # e.g.: text(32)
          
          #todo pay attention to cardinality
          #sourceCardinality
          #destinationCardinality
          # ^^ this is the info for has_many/belongs to
          # this field is referencing another table
          # meaning this table has a foreign key reference to another table
          # if the destination cardinality is 1 ( or 0 ? )
          # then it's a belongs_to 
          
          # if the destination cardinality is > 1
          # it could be a habtm... we'd need to check the table it's referencing
          # and check to see if it contains the name of the current model
          # parts_orders <-- join table
          
          # if the source cardinality is 1 then 
          # the other model could have a has_one of this model
          
          # otherwise the other model could have a has_many
          
        }
        sql_fields << f
      end
      return sql_fields
    end
    
    def indexes(table)
      table.xpath('SQLIndex').collect do |field|
        puts "field: #{field}"
        {
          :name => field.xpath('name').text,
          :fieldNames => field.xpath('fieldName').map { |f| f.text },
          :notNull => field.xpath('notNull').text,
        }
      end
    end
    
  end
end
