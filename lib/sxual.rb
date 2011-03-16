require 'nokogiri'
require 'trollop'

require 'sxual/args'
require 'sxual/xpath'
require 'sxual/sqs_parser'
require 'sxual/walkers/base_walker'
require 'sxual/walkers/default_walker'
require 'sxual/walkers/schema_walker'

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

      Walkers::DefaultWalker.new(sqs.tables).print()
      
    end
  end
end
