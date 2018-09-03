require 'keytechKit/classes/layout/layout'


module KeytechKit
  class Layouts
    include HTTParty

    def initialize(base_url, username, password)
      self.class.base_uri(base_url)
      @auth = { username: username, password: password }
    end

    def header_layout(classkey)
        # Ab keytedch 14!
        load_layout(classkey, {"layoutType": "HeaderLayout"})
    end

    def main_layout(classkey)
        load_layout(classkey, {"layoutType": "DefaultLayout"})
    end

    def explorer_layout(classkey)
        load_layout(classkey, {"layoutType": "ExplorerLayout"})
    end

    private

      def load_layout(classKey, options = {})
        parameter = {query: options}
        parameter.merge!({ basic_auth: @auth })

        response = self.class.get("/classes/#{classKey}/editorlayout", parameter)
        if response.success?
          # create a class
           Layout.new(response)
         else
           raise response.response
        end
      end
  end
end
