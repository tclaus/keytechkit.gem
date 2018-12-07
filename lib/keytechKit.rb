require 'httparty'
require 'keytechKit/response_helper'
require 'keytechKit/version'
require 'keytechKit/serverinfo_handler'
require 'keytechKit/search'
require 'keytechKit/user'
require 'keytechKit/elements/element_handler'
require 'keytechKit/elements/notes/note_handler'
require 'keytechKit/classes/classes'
require 'keytechKit/classes/layouts'
require 'keytechKit/classes/layout/layout'
require 'keytechKit/elements/element_files/element_file_handler'
require 'keytechKit/elements/data_dictionary/data_dictionary_handler'

module KeytechKit
  ##
  # This class is the interface controller to the keytech Web API
  # Use the helper functions to access various resources from the API
  #
  class KeytechKit
    attr_reader :base_url
    attr_reader :username
    attr_reader :password


    # Initializes this class
    # user +baseurl+, +username+ and +password+ to start accessing all other
    # keytech API resources
    #
    def initialize(baseurl, username = '', password = '')
      @base_url = baseurl
      @username = username
      @password = password
    end

    # Returns the Serverinfo @see +ServerInfo+ for details
    # This should be always the first call whenever starting with keytech API.
    # ServerInfo will give valuable information about server access, version
    # number and functions
    #
    def serverinfo
      @serverinfo_handler = ServerInfoHandler.new(self, @base_url) if @serverinfo_handler.nil?
      @serverinfo_handler.load
    end

    # Returns the login in user.
    # This is always the user with which you Initialized this classes
    # Check this object to see if the user is active and have API access.
    def current_user
      if @_curent_user.nil?
        user = User.new(@base_url, @username, @password)
        @_curent_user = user.load(@username)
      end
      @_curent_user
    end

    # Returns the Elements resource. You will need to specify alwys the concrete
    # Element you want to access. keytech API does not support to return bulk
    # Lists of Elements
    #
    def element_handler
      @_element_handler = ElementHandler.new(self, @base_url, @username, @password) if @_element_handler.nil?
      @_element_handler
    end

    # Returns the Data Dictionaries. Data Dictionary (DD) will give lookup tables
    # you will need to fill various element fields.
    def data_dictionary_handler
      @data_dictionary_handler = DataDictionaryHandler.new(self, @base_url, @username, @password) if @data_dictionary_handler.nil?
      @data_dictionary_handler
    end

    # Returns the classes object.
    # A class in terms of keytech describes a type of elements.
    # A class describes the attributes, its types and it supported layouts to make
    # certain elements visible for a user.
    def classes
      @classes = Classes.new(@base_url, @username, @password) if @classes.nil?
      @classes
    end

    # TODO: Move Laoyuts under classes
    # returns the layout class. Eveny class can have a layout which describes
    # the attribues with its type, acccess, datadictionary and if it is
    # visible to the user.
    def layouts
      @_layouts = Layouts.new(@base_url, @username, @password) if @_layouts.nil?
      @_layouts
    end

    # Returns the Search Object
    # With the search you can start a fulltextsearch, search by field, type or
    # access a predefined search on the server side for elements
    #
    def search
      @_search = Search.new(@base_url, @username, @password) if @_search.nil?
      @_search
    end
  end
end
