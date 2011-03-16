
# accepts a nokogiti XML node/nodeset and Lumber::info a safe wrapper
# around missing content/text node queries
module Sxual
  class Xpath
    def initialize(xml)
      @xml = xml
    end
    
    # shortform for getting at the XmlNode::text
    # namespace should be a hash {'media' => 'http://fakuri.com/voodoo'}
    def [](xpath, namespace={})
      begin
        @xml.at_xpath(xpath, namespace).text
      rescue => error
        # if Sxual::DEBUG
        #   puts "Xpath error: xpath='#{xpath}' :: #{error}"
        # end

        return ''
      end
    end

    # if XPATH exists return the yes_val
    # OR return the no_val if it does not exist
    # i.e. an XPATH that return a "1" will return true or false
    # if_exists('shitaki', true, false)
    # basically existence of the XPATH node will return yes_val
    def if_exists(xpath, yes_val, no_val)
      if self[xpath].size > 0
        yes_val
      else
        no_val
      end
    end
    
    # returns the Nokogiri XML Element
    def at(xpath, namespace={})
      begin
        @xml.at_xpath(xpath)
      rescue => error
        if Sxual::DEBUG
          puts "ERROR - Xpath#at(#{xpath}), #{error}"
        end
        
        return ''
      end
    end
  end
end
