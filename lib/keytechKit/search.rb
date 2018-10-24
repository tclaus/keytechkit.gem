require 'keytechKit/elements/element'
require 'keytechKit/elements/searchResponseHeader'

module KeytechKit
  class Search
    include HTTParty

    attr_accessor :response

    def initialize(base_url, username, password)
      self.class.base_uri(base_url)
      @auth = { username: username, password: password }
    end

    #options = {};
    #:q = searchtext - optional parameter: makes a fulltext search, (unusable on very large data)
    #:size
    #:page
    #:attributes = "ALL","None","Lister", "Editor", "GlobalLister", "System", "Secondary", "Explorer"
    #:reload = true
    #:classes = "DEFAULT_DO","DEFAULT_FD", "DEFAULT_MI", "DEFAULT_MAIL","DEFAULT_TASK"
    #:fields = [<attribute><operator><value>:] - as_do__created_by=jgrant:as_do_changed_by=pmiller - finds all elememnts cerated by jgrant and changed by pmiller
    # Remeber: dates must be send in epoch format! "/date(1464127200000)/"
     def query(options = {})
       parameter = {query: options}
       parameter.merge!({ basic_auth: @auth })
       response = self.class.get("/search", parameter)
       if response.success?
          self.response = response
          parse_response
        else
          puts "Could not execute query: #{save_response.headers['x-errordescription']}"
       end
     end

    private

     def parse_response
        SearchResponseHeader.new(self.response)
     end

  end
end
