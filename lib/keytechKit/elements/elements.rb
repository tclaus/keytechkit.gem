require 'keytechKit/elements/element'
require 'keytechKit/elements/searchResponseHeader'


module KeytechKit
  class Elements
    include HTTParty

    def initialize(base_url, username, password)
      self.class.base_uri(base_url)
      @auth = { username: username, password: password }
    end

    ##
    # Find an existing element with +elementkey+ in form of classkey:<nummeric>
    # e.g.: MISC_FILE:1234
    # +options+ is one of attributes=ALL|NONE|EDITOR
    
    def find(id, options = {})
      parameter = {query: options}
      parameter.merge!({ basic_auth: @auth })

      response = self.class.get("/elements/#{id}", parameter)

      if response.success?
        searchResponseHeader = SearchResponseHeader.new(response)
        searchResponseHeader.elementList.first
       else
         raise response.response
      end
    end

    def save(element)
      #TODO: Save element
    end


  end
end
