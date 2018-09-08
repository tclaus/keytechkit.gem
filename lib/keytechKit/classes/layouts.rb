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

    def lister_layout(classkey)
        load_lister_layout(classkey)
    end

    def global_lister_layout
      # type, displaytext, name, status, created_at, created_by
      Layout.new('DesignerControls' => [
                   { 'AttributeName' => 'classname',
                     'Displayname' => 'Klasse' },
                   { 'AttributeName' => 'displayname',
                     'Displayname' => 'Bezeichnung' },
                   { 'AttributeName' => 'status',
                     'Displayname' => 'Status' },
                   { 'AttributeName' => 'created_by',
                     'Displayname' => 'Angelegt von' },
                   { 'AttributeName' => 'created_at',
                     'Displayname' => 'Angelegt am' }
                 ])
    end

    private

    def load_lister_layout(classKey)
      parameter = { basic_auth: @auth }

      response = self.class.get("/classes/#{classKey}/listerlayout", parameter)
      if response.success?
         Layout.new(response)
       else
         raise response.response
      end
    end

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
