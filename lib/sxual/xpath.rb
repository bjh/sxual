
# accepts a nokogiti XML node/nodeset and Lumber::info a safe wrapper
# around missing content/text node queries
module Sxual
  class Xpath
    def initialize(xml)
      @xml = xml
    end
    
    # shortform for getting at the XmlNode::text
    # namespace should be a hash {'media' => 'http://fakuri.com/voodoo'}
    def [](xpath, default=:none, namespace={})
      begin
        @xml.at_xpath(xpath, namespace).text
      rescue => error
        if Sxual::DEBUG
          puts "Xpath error: xpath='#{xpath}' :: #{error}"
        end

        if default == :none
          puts "returning empty string"
          ''
        else
          puts "returning default #{default}"
          default
        end
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
