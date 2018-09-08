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

module KeytechKit

  class Keytech_Kit
      # set base url
      # setusername / Password
      # get functions
      attr_accessor :base_url
      attr_accessor :username
      attr_accessor :password

      attr_accessor :currentUser
      attr_accessor :elements
      attr_accessor :notes
      attr_accessor :classes
      attr_accessor :layouts

      def initialize(baseurl, username = "" ,password = "")
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

      # Search
      #   - elements
      #   - elements key value list
      # search(q=,classes=,  attributes= reload=, size=, page=)
      # search(ByQuery=, attributes= reload=, size=, page=)
      def search(query,options = {})
        search = Search.new(@base_url, @username, @password)
        search.query(query,options)
      end

      def currentUser()
        if @currentUser == nil
          user = User.new(@base_url, @username, @password)
          @currentUser = user.load(@username)
        end
        @currentUser
      end

      def elements()
        if @elements == nil
          @elements = Elements.new(self, @base_url, @username, @password)
        end
        @elements
      end

      def notes()
        if @notes == nil
          @notes = Notes.new(@base_url, @username, @password)
        end
        @notes
      end

      def classes()
        if @classes == nil
          @classes = Classes.new(@base_url, @username, @password)
        end
        @classes
      end

      def layouts()
        if @layouts == nil
          @layouts = Layouts.new(@base_url, @username, @password)
        end
        @layouts
      end


  # user / favorites / queries

  # queries: stored queries, parameter queries

  # classes
  # layouts

  # element / elements / bom, structure, notes, files usw..

  end

end
