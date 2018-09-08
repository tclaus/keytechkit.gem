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

    def load(elementKey, options = {})
      parameter = {query: options}
      parameter.merge!({ basic_auth: @auth })

      response = self.class.get("/elements/#{elementKey}", parameter)

      if response.success?
        searchResponseHeader = SearchResponseHeader.new(response)
        searchResponseHeader.elementList.first
       else
         raise response.response
      end
    end


    # Loads the structure
    # +options+ can have these values: size, page, attribute = ALL|NONE|GLOBALLISTER|SECONDARY|EXPLORER
    # Returns a list of elements
    def structure(elementKey, options = {})
      parameter = {query: options}
      parameter.merge!({ basic_auth: @auth })
      response = self.class.get("/elements/#{elementKey}/structure", parameter)
      searchResponseHeader = SearchResponseHeader.new(response)

      return searchResponseHeader.elementList
    end

    # Loads the parent elements
    # +options+ can have these values: size, page, attribute = ALL|NONE|GLOBALLISTER|SECONDARY|EXPLORER
    # Returns a list of elements
    def whereused(elementKey, options = {})
      parameter = {query: options}
      parameter.merge!({ basic_auth: @auth })

      response = self.class.get("/elements/#{elementKey}/whereused", parameter)
      searchResponseHeader = SearchResponseHeader.new(response)

      return searchResponseHeader.elementList
    end

    def notes(elementkey)
      parameter = { basic_auth: @auth }

      response = self.class.get("/elements/#{elementKey}/notes", parameter)
      searchResponseHeader = SearchResponseHeader.new(response)

      return searchResponseHeader.elementList
    end


    # Loads the preview image. This is always a smaller, not for direct use image file
    def preview(elementKey)

      parameter = { basic_auth: @auth }
      response = self.class.get("/elements/#{elementKey}/preview", parameter)

      return response
    end

    # Loads a small thumbnail
    def thumbnail(elementKey)
      parameter = { basic_auth: @auth }
      response = self.class.get("/elements/#{elementKey}/thumbnail", parameter)

      return response
    end

    def save(element)
      #TODO: Save element
    end


  end
end
