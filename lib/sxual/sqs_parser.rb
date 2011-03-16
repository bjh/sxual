
module Sxual
  class SqsParser
    attr_reader :tables
    
    def initialize
      @tables = []
    end
    
    def parse(file)
      begin
        @xml = Nokogiri::XML(File.open(file))
        @tables = read()
      rescue => e
        puts "SqsParser::parse: #{e}"
      end
    end

    def read()
      @xml.xpath('SQLContainer/SQLTable').collect do |table|
        {
          :name => table.xpath('name').text,
          :contraints => constraints(table),
          #:indexes => indexes(table),
          :fields => fields(table),
        }
      end
    end
    
    def constraints(table)
      table.xpath('SQLConstraint').collect do |constraint|
        puts "CONSTRAINT: #{constraint}"
        xp = Xpath.new(constraint)
        
        {
          :name => xp['name'],
          #:field_names => xp['fieldName'].map { |f| f.text },
          :index_type => xp['indexType'],
        }
      end
    end
    
    def fields(table)
      table.xpath('SQLField').collect do |field|
        xp = Xpath.new(field)

        {
          :name => xp['name'],
          :type => xp['type'],
          :not_null => xp.if_exists('notNull', true, false),
          # this may have mutliple fields, and would be getting squashed
          #:referencesField => xp['referencesField').first,
          #:referencesTable => xp['referencesTable').first.text,
          
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
      end
    end
    
    def indexes(table)
      table.xpath('SQLIndex').collect do |index|
        puts "index: #{index}"
        {
          :name => index.xpath('name').text,
          :field_names => index.xpath('fieldName').map { |f| f.text },
          :not_null => index.xpath('notNull').text,
        }
      end
    end
    
  end
end
