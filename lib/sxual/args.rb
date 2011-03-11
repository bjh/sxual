module Sxual

  class Args
    def initialize
      @options = {}
    end

    def set?(key)
      !@options[key.to_sym].nil?
    end

    def value(key)
      @options[key.to_sym]
    end
    
    def parse
      opts = Trollop::options do
        opt :file, ".sqs file to load", :type => :string
      end

      @options = opts
    end
  end
end
