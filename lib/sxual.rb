require 'nokogiri'
require 'trollop'

require 'sxual/args'

module Sxual
  class Application
    def run
      args = Args.new
      args.parse

      # puts args.set? :monkey
      # puts args.set? :goat
    end
  end
end
