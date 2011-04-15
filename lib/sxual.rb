require 'nokogiri'
require 'trollop'

require_relative 'sxual/args'
require_relative 'sxual/xpath'
require_relative 'sxual/sqs_parser'
require_relative 'sxual/walkers/base_walker'
require_relative 'sxual/walkers/default_walker'
require_relative 'sxual/walkers/schema_walker'

module Sxual
  DEBUG = true
  
  class Application
    def run
      args = Args.new
      args.parse

      if ! args.set? :file
        puts "sxual cannot get busy without a file"
        exit(69)
      end
      
      puts "don't bother knocking...\nsxual is getting it's groove on with [#{args.value(:file)}]"
      
      parser = SqsParser.new
      #parser.parse(args.value(:file))
      
      sqs = SqsParser.new
      sqs.parse(args.value(:file))

      #Walkers::DefaultWalker.new(sqs.tables).walk()
      Walkers::SchemaWalker.new(sqs.tables).walk()
      
    end
  end
end
