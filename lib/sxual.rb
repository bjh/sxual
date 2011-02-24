require 'nokogiri'
require 'trollop'

require 'sxual/args'
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
      SqsParser.parse(args.value(:file))
    end
  end
end
