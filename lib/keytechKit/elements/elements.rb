require 'keytechKit/elements/element'
require 'keytechKit/elements/searchResponseHeader'


module KeytechKit
  class Elements
    include HTTParty

    attr_accessor :keytechkit

    def initialize(keytechkit, base_url, username, password)
      self.class.base_uri(base_url)
      @auth = { username: username, password: password }
      @keytechkit = keytechkit
    end

    ##
    # Find an existing element with +elementkey+ in form of classkey:<nummeric>
    # e.g.: MISC_FILE:1234
    # +options+ is one of attributes=ALL|NONE|EDITOR

    def find(elementKey, options = {})
      parameter = {query: options}
      parameter.merge!({ basic_auth: @auth })

      response = self.class.get("/elements/#{elementKey}", parameter)

      if response.success?
        searchResponseHeader = SearchResponseHeader.new(@keytechkit, response)
        searchResponseHeader.elementList.first
       else
         raise response.response
      end
    end

    # Loads the preview image. This is always a smaller, not for direct use image file
    def preview(elementKey)
      # Global userinfo?
      result = HTTParty.get("#{keytechkit.base_url}/elements/#{elementKey}/preview",
                                          :basic_auth => {
                                                :username => keytechkit.username,
                                                :password => keytechkit.password})

      return result
    end

    # Loads a small thumbnail
    def thumbnail(elementKey)
      # Global userinfo?
      result = HTTParty.get("#{keytechkit.base_url}/elements/#{elementKey}/thumbnail",
                                          :basic_auth => {
                                                :username => keytechkit.username,
                                                :password => keytechkit.password})

      return result
    end

    def save(element)
      #TODO: Save element
    end


  end
end
