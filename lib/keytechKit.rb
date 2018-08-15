require "HTTParty"
require "keytechKit/version"
require "keytechKit/serverinfo"
require "keytechKit/search"

class Keytech_Kit
    # set base url
    # setusername / Password
    # get functions
    attr_accessor :base_url
    attr_accessor :username
    attr_accessor :password

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

end
