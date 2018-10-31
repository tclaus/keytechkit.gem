require "httparty"
require "keytechKit/version"
require "keytechKit/serverinfo"
require "keytechKit/search"
require "keytechKit/user"
require "keytechKit/elements/elements"
require "keytechKit/elements/notes/notes"
require "keytechKit/classes/classes"
require "keytechKit/classes/layouts"
require "keytechKit/classes/layout/layout"
require "keytechKit/elements/elementFiles/elementFiles"
require "keytechKit/elements/dd/dataDictionaries"

module KeytechKit
  class Keytech_Kit
      # set base url
      # setusername / Password
      # get functions
      attr_accessor :base_url
      attr_accessor :username
      attr_accessor :password

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

      def set_base_url(baseurl)
        @base_url = baseurl
      end

      def set_username(username)
        @username = username
      end

      def set_userpassword(password)
        @password = password
      end

      # Functions here
      def serverinfo
        Serverinfo.load(base_url)
      end

      def currentUser
        if @_currentUser == nil
          user = User.new(@base_url, @username, @password)
          @_currentUser = user.load(@username)
        end
        @_currentUser
      end

      def elements
        if @_elements.nil?
          @_elements = Elements.new(self, @base_url, @username, @password)
        end
        @_elements
      end

      def dataDictionaries
        if @_dataDictionaries.nil?
          @_dataDictionaries = DataDictionaries.new(self, @base_url, @username, @password)
        end
        @_dataDictionaries
      end

      def notes
        if @_notes.nil?
          @_notes = Notes.new(@base_url, @username, @password)
        end
        @_notes
      end

      def classes
        if @classes.nil?
          @classes = Classes.new(@base_url, @username, @password)
        end
        @classes
      end

      def layouts
        if @_layouts.nil?
          @_layouts = Layouts.new(@base_url, @username, @password)
        end
        @_layouts
      end

      def files
        @_files = ElementFiles.new(@base_url, @username, @password) if @_files.nil?
        @_files
      end

      def search
        if @_search.nil?
          @_search = Search.new(@base_url, @username, @password)
        end
        @_search
      end
  end
end
