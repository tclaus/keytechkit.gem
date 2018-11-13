require 'keytechKit/elements/element'
require 'keytechKit/elements/search_response_header'
require 'keytechKit/elements/bom/bom_element_list'

module KeytechKit
  ##
  # All operations for a element is here
  class ElementHandler
    include HTTParty
    default_timeout 10

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
    def load(element_key, options = {})
      parameter = { query: options }
      parameter[:basic_auth] = @auth

      response = self.class.get("/elements/#{element_key}", parameter)

      if response.success?
        searchResponseHeader = SearchResponseHeader.new(response)
        searchResponseHeader.elementList.first
        # TODO: Can we do better if element was not found?
      end
    end

    # It returns a element prototype with the given elementKey
    # you can check valid elementkeys with the classdefinition
    def new_element(key)
      Element.new('Key' => key)
    end

    # Saves a element to keytech web api and returns the saved element.
    # If anything goes wrong - a http response is returned
    def save(element)
      elementHash = element.to_hash
      parameter = { basic_auth: @auth,
                    body: elementHash.to_json,
                    headers: { 'Content-Type' => 'application/json; charset=utf-8 ' } }
      save_response = self.class.post('/elements', parameter)
      if save_response.success?
        Element.new(save_response.parsed_response)
      else
        puts "Could not save element: #{save_response.headers['x-errordescription']}"
      end
    end

    # Saves a element to keytech web api and returns the saved element.
    # If anything goes wrong - a http response is returned
    def update(element)
      elementHash = element.to_hash
      parameter = { basic_auth: @auth,
                    body: elementHash.to_json,
                    headers: { 'Content-Type' => 'application/json; charset=utf-8 ' } }
      save_response = self.class.put("/elements/#{element.key}", parameter)
      if save_response.success?
        Element.new(save_response.parsed_response)
      else
        puts "Could not save element: #{save_response.headers['x-errordescription']}"
      end
    end

    # Deletes an element with the key
    # It returns the http response.
    def delete(element_key)
      parameter = { basic_auth: @auth }
      response = self.class.delete("/elements/#{element_key}", parameter)
      unless response.success?
        puts "Could not save element: #{response.headers['x-errordescription']}"
      end
      response
    end

    # Loads the structure
    # +options+ can have these values: size, page, attribute = ALL|NONE|GLOBALLISTER|SECONDARY|EXPLORER
    # Returns a list of elements
    # It returns nil if no element with this elementKey was found
    def structure(element_key, options = {})
      parameter = { query: options }
      parameter[:basic_auth] = @auth
      response = self.class.get("/elements/#{element_key}/structure", parameter)
      if response.success?
        searchResponseHeader = SearchResponseHeader.new(response)
        return searchResponseHeader.elementList
      end
    end

    # Loads the parent elements
    # +options+ can have these values: size, page, attribute = ALL|NONE|GLOBALLISTER|SECONDARY|EXPLORER
    # Returns a list of elements
    # It returns nil if no element with this elementKey was found
    def whereused(element_key, options = {})
      parameter = { query: options }
      parameter[:basic_auth] = @auth

      response = self.class.get("/elements/#{element_key}/whereused", parameter)
      if response.success?
        searchResponseHeader = SearchResponseHeader.new(response)
        return searchResponseHeader.elementList
      end
    end

    # Loads the bill of meterial on articles
    # +options+ can have these values: size, page, attribute = ALL|NONE|GLOBALLISTER|SECONDARY|EXPLORER
    # Returns a list of elements
    # It returns nil if no element with this elementKey was found
    def billOfMaterial(element_key, options = {})
      parameter = { query: options }
      parameter[:basic_auth] = @auth

      response = self.class.get("/elements/#{element_key}/bom", parameter)
      if response.success?
        bom_list = BomElementList.new(response)
        return bom_list.bomElementList
      end
    end

    # Loads the list of mails on folders,
    # +options+ can have these values: size, page, attribute = ALL|NONE|GLOBALLISTER|SECONDARY|EXPLORER
    # Returns a list of elements
    # It returns nil if no element with this elementKey was found
    def mails(element_key, options = {})
      parameter = { query: options }
      parameter[:basic_auth] = @auth

      response = self.class.get("/elements/#{element_key}/mails", parameter)
      return response['ElementList'] if response.success?
    end

    # It returns the notes of an element if anything are given
    # Notes list can be empty
    # It returns nil if no element with this elementKey was found
    def notes(element_key)
      parameter = { basic_auth: @auth }

      response = self.class.get("/elements/#{element_key}/notes", parameter)
      if response.success?
        search_response_header = SearchResponseHeader.new(response)
        search_response_header.elementList
      end
    end

    # Returns Notes resource.
    # Every Element can have zero, one or more notes.
    # You can notes only access in context of its element which ownes the notes
    def note_handler
      @_note_handler = NoteHandler.new(keytechkit.base_url, keytechkit.username, keytechkit.password) if @_note_handler.nil?
      @_note_handler
    end

    # Returns the file object.
    # Every element can have a Masterfile and one or more preview files
    def file_handler
      @_element_file_handler = ElementFileHandler.new(keytechkit.base_url, keytechkit.username, keytechkit.password) if @_element_file_handler.nil?
      @_element_file_handler
    end

    # Loads the preview image. This is a size limited image version of the files
    # content. Text documents often show the first Page.
    # Make no assumtions about the image size
    def preview(element_key)
      parameter = { basic_auth: @auth }
      self.class.get("/elements/#{element_key}/preview", parameter)
    end

    # Loads a small thumbnail. Thumbnails are like file type icons.
    # They normaly show the type of a document, not its content
    def thumbnail(element_key)
      parameter = { basic_auth: @auth }
      self.class.get("/elements/#{element_key}/thumbnail", parameter)
    end
  end
end
