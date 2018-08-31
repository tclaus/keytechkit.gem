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
    #:size
    #:page
    #:attributes = "ALL","None","Lister", "Editor", "GlobalLister", "System", "Secondary", "Explorer"
    #:reload = true
    #:classes = "DEFAULT_DO","DEFAULT_FD", "DEFAULT_MI", "DEFAULT_MAIL","DEFAULT_TASK"

     def query(query,options = {})
       options = permitOptions(options)
       options[:q] = query
       parameter = {query: options}
       parameter.merge!({ basic_auth: @auth })

       response = self.class.get("/search", parameter)
       if response.success?
          self.response = response
          parse_response
        else
          raise response.response
       end
     end

    private

     def parse_response
        SearchResponseHeader.new(self.response)
     end

     def permitOptions(options={})
        permittedOptions = {}
        setKeyIfPresent(options,permittedOptions,:classes)
        setKeyIfPresent(options,permittedOptions,:attributes)
        setKeyIfPresent(options,permittedOptions,:size)
        setKeyIfPresent(options,permittedOptions,:page)
        setKeyIfPresent(options,permittedOptions,:reload)
        permittedOptions
     end

     def setKeyIfPresent(options, permittetOptions, key)
         if options.key?(key)
           permittedOptions[key] = options[key]
         end
     end

  end
end
