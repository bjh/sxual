require 'nokogiri'
require 'trollop'

require 'sxual/args'
require 'sxual/xpath'
require 'sxual/sqs_parser'

module Sxual
  class Application
    def run
      args = Args.new
      args.parse

      if ! args.set? :file
        puts "no file to parse"
        exit(69)
      end
      
      puts "don't bother knocking...\nsxual is getting it's groove on with [#{args.value(:file)}]"
      
      parser = SqsParser.new
      #parser.parse(args.value(:file))
      
      sqs = SqsParser.new
      sqs.parse(args.value(:file)) do |table|
        puts table.inspect

        table.fields do |f|
           puts f
        end
        # 
        # table.constraints do |c|
        #   puts c
        # end
        # 
        # table.indexes do |i|
        #   puts i
        # end

      end
      
    end
  end
end
