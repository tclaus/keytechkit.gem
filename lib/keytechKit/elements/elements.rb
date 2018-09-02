require 'keytechKit/elements/element'
require 'keytechKit/elements/searchResponseHeader'


module KeytechKit
  class Elements
    include HTTParty

    def initialize(base_url, username, password)
      self.class.base_uri(base_url)
      @auth = { username: username, password: password }
    end

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
    end


  end
end
