require 'keytechKit/elements/element'
require 'keytechKit/elements/searchResponseHeader'
require 'keytechKit/elements/bom/billOfMaterial'

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
    # It returns nil if no element with this elementKey was found
    def load(elementKey, options = {})
      parameter = { query: options }
      parameter[:basic_auth] = @auth

      response = self.class.get("/elements/#{elementKey}", parameter)

      if response.success?
        searchResponseHeader = SearchResponseHeader.new(response)
        searchResponseHeader.elementList.first
        # TODO: Can we do better if element was not found?
      end
    end

    # It returns a element prototype with the given elementKey
    # you can check valid elementkeys with the classdefinition
    def newElement(key)
      Element.new('Key' => key)
    end

    # Saves a element to keytech web api and returns the saved element.
    # If anything goes wrong - a http response is returned
    def save(element)
      elementHash = element.to_hash
      parameter = { basic_auth: @auth,
        :body     => elementHash.to_json,
        :headers  => { 'Content-Type' => 'application/json; charset=utf-8 ' }
        }
      save_response = self.class.post("/elements",parameter)
      if save_response.success?
        Element.new(save_response.parsed_response)
      else
        logger.warn "Could not save element: #{save_response.headers['x-errordescription']}"
      end
    end

    # Saves a element to keytech web api and returns the saved element.
    # If anything goes wrong - a http response is returned
    def update(element)
      elementHash = element.to_hash
      parameter = { basic_auth: @auth,
        :body => elementHash.to_json,
        :headers => { 'Content-Type' => 'application/json; charset=utf-8 ' }
      }
      save_response = self.class.put("/elements/#{element.key}",parameter)
      if save_response.success?
        Element.new(save_response.parsed_response)
      else
        puts "Could not save element: #{save_response.headers['x-errordescription']}"
      end
    end

    # Deletes an element with the key
    # It returns the http response.
    def delete(element_key)
      parameter = { basic_auth: @auth}
      response = self.class.delete("/elements/#{element_key}", parameter)
      if !response.success?
        puts "Could not save element: #{response.headers['x-errordescription']}"
      end
      response
    end

    # Loads the structure
    # +options+ can have these values: size, page, attribute = ALL|NONE|GLOBALLISTER|SECONDARY|EXPLORER
    # Returns a list of elements
    # It returns nil if no element with this elementKey was found
    def structure(elementKey, options = {})
      parameter = { query: options }
      parameter[:basic_auth] = @auth
      response = self.class.get("/elements/#{elementKey}/structure", parameter)
      if response.success?
        searchResponseHeader = SearchResponseHeader.new(response)
        return searchResponseHeader.elementList
      end
    end

    # Loads the parent elements
    # +options+ can have these values: size, page, attribute = ALL|NONE|GLOBALLISTER|SECONDARY|EXPLORER
    # Returns a list of elements
    # It returns nil if no element with this elementKey was found
    def whereused(elementKey, options = {})
      parameter = { query: options }
      parameter[:basic_auth] = @auth

      response = self.class.get("/elements/#{elementKey}/whereused", parameter)
      if response.success?
        searchResponseHeader = SearchResponseHeader.new(response)
        return searchResponseHeader.elementList
      end
    end

    # Loads the bill of meterial on articles
    # +options+ can have these values: size, page, attribute = ALL|NONE|GLOBALLISTER|SECONDARY|EXPLORER
    # Returns a list of elements
    # It returns nil if no element with this elementKey was found
    def billOfMaterial(elementKey, options = {})
      parameter = { query: options }
      parameter[:basic_auth] = @auth

      response = self.class.get("/elements/#{elementKey}/bom", parameter)
      if response.success?
        billOfMaterial = BillOfMaterial.new(response)
        return billOfMaterial.bomElementList
      end
    end

    # Loads the list of mails on folders,
    # +options+ can have these values: size, page, attribute = ALL|NONE|GLOBALLISTER|SECONDARY|EXPLORER
    # Returns a list of elements
    # It returns nil if no element with this elementKey was found
    def mails(elementKey, options = {})
      parameter = { query: options }
      parameter[:basic_auth] = @auth

      response = self.class.get("/elements/#{elementKey}/mails", parameter)
      if response.success?
        return response['ElementList']
      end
    end

    # It returns the notes of an element if anything are given
    # Notes list can be empty
    # It returns nil if no element with this elementKey was found
    def notes(element_key)
      parameter = { basic_auth: @auth }

      response = self.class.get("/elements/#{element_key}/notes", parameter)
      if response.success?
        searchResponseHeader = SearchResponseHeader.new(response)
        searchResponseHeader.elementList
      end
    end

    # Loads the preview image. This is a size limited image version of the files
    # content. Text documents often show the first Page.
    # Make no assumtions about the image size
    def preview(elementKey)
      parameter = { basic_auth: @auth }
      self.class.get("/elements/#{elementKey}/preview", parameter)
    end

    # Loads a small thumbnail. Thumbnails are like file type icons.
    # They normaly show the type of a document, not its content
    def thumbnail(elementKey)
      parameter = { basic_auth: @auth }
      self.class.get("/elements/#{elementKey}/thumbnail", parameter)
    end
  end
end
