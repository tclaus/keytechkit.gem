require 'keytechKit/elements/element'
require 'keytechKit/elements/search_response_header'

module KeytechKit
  ##
  # Can search the API by fulltext, fields, element types
  # Can search by a predefined 'stored' query by its queryID
  # Can sort the results
  # Can group the results
  class Search
    include HTTParty
    default_timeout 10

    attr_accessor :response

    def initialize(base_url, username, password)
      self.class.base_uri(base_url)
      @auth = { username: username, password: password }
    end

    # options = {};
    #:q = searchtext - optional parameter: makes a fulltext search, (unusable on very large data)
    #:size
    #:page
    #:attributes = "ALL","None","Lister", "Editor", "GlobalLister", "System", "Secondary", "Explorer"
    #:reload = true
    #:classes = "DEFAULT_DO","DEFAULT_FD", "DEFAULT_MI", "DEFAULT_MAIL","DEFAULT_TASK"
    #:fields = [<attribute><operator><value>:] - as_do__created_by=jgrant:as_do_changed_by=pmiller - finds all elememnts cerated by jgrant and changed by pmiller
    # Remember: dates must be send in epoch format! "/date(1464127200000)/"
    def query(options = {})
      parameter = { query: options }
      parameter[:basic_auth] = @auth
      response = self.class.get('/search', parameter)
      if response.success?
        parse_response(response)
      else
        puts "Could not execute query: #{parse_response.headers['x-errordescription']}"
      end
    end

    private

    def parse_response(response)
      SearchResponseHeader.new(response)
    end
  end
end
