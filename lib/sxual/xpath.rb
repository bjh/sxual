
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
        if Sxual::DEBUG
          puts "Xpath error: #{xpath} - #{e}"
        end
        
        ''
      end
    end
    
    # returns the Nokogiri XML Element
    def at(xpath, namespace={})
      begin
        @xml.at_xpath(xpath)
      rescue => error
        if Sxual::DEBUG
          Lumber::info "ERROR - Xpath#at(#{xpath})"
        end
        
        ''
      end
    end
  end
end
