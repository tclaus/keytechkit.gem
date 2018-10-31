require 'httparty'
require 'keytechKit/version'
require 'keytechKit/serverinfoController'
require 'keytechKit/search'
require 'keytechKit/user'
require 'keytechKit/elements/elements'
require 'keytechKit/elements/notes/notes'
require 'keytechKit/classes/classes'
require 'keytechKit/classes/layouts'
require 'keytechKit/classes/layout/layout'
require 'keytechKit/elements/elementFiles/elementFiles'
require 'keytechKit/elements/dd/dataDictionaries'

module KeytechKit
  class Keytech_Kit
    # set base url
    # setusername / Password
    # get functions
    attr_accessor :base_url
    attr_accessor :username
    attr_accessor :password
    attr_accessor :serverinfo_controller
    attr_accessor :_currentUser
    attr_accessor :_elements
    attr_accessor :_dataDictionaries
    attr_accessor :_notes
    attr_accessor :_classes
    attr_accessor :_layouts
    attr_accessor :_files
    attr_accessor :_search

    def initialize(baseurl, username = '', password = '')
      @base_url = baseurl

      @username = username
      @password = password
    end

    # Functions here
    def serverinfo
      @serverinfo_controller = ServerinfoController.new(self, @base_url) if @serverinfo_controller.nil?
      @serverinfo_controller.load
    end

    def currentUser
      if @_currentUser.nil?
        user = User.new(@base_url, @username, @password)
        @_currentUser = user.load(@username)
      end
      @_currentUser
    end

    def elements
      @_elements = Elements.new(self, @base_url, @username, @password) if @_elements.nil?
      @_elements
    end

    def dataDictionaries
      @_dataDictionaries = DataDictionaries.new(self, @base_url, @username, @password) if @_dataDictionaries.nil?
      @_dataDictionaries
    end

    def notes
      @_notes = Notes.new(@base_url, @username, @password) if @_notes.nil?
      @_notes
    end

    def classes
      @classes = Classes.new(@base_url, @username, @password) if @classes.nil?
      @classes
    end

    def layouts
      @_layouts = Layouts.new(@base_url, @username, @password) if @_layouts.nil?
      @_layouts
    end

    def files
      @_files = ElementFiles.new(@base_url, @username, @password) if @_files.nil?
      @_files
    end

    def search
      @_search = Search.new(@base_url, @username, @password) if @_search.nil?
      @_search
    end
  end
end
