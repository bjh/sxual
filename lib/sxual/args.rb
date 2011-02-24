module Sxual

  class Args
    def initialize
      @options = {}
    end

    def set?(key)
      @options[key.to_sym]
    end
    
    def parse
      opts = Trollop::options do
        opt :monkey, "Use monkey mode"                     # flag --monkey, default false
        opt :goat, "Use goat mode", :default => true       # flag --goat, default true
        opt :num_limbs, "Number of limbs", :default => 4   # integer --num-limbs <i>, default to 4
        opt :num_thumbs, "Number of thumbs", :type => :int # integer --num-thumbs <i>, default nil
      end

      #p opts # a hash: { :monkey => false, :goat => true, :num_limbs => 4, :num_thumbs => nil }
      @options = opts
    end
  end
end
