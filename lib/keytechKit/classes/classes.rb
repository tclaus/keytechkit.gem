require 'keytechKit/classes/classdefinition'

module KeytechKit
  class Classes
    include HTTParty

    def initialize(base_url, username, password)
      self.class.base_uri(base_url)
      @auth = { username: username, password: password }
    end

    def load(classKey, options = {})
      # Returns a classclasses
      parameter = {query: options}
      parameter.merge!({ basic_auth: @auth })

      response = self.class.get("/classes/#{classKey}", parameter)

      if response.success?
        # create a class
        ClassDefinition.new(response)
       else
         raise response.response
      end
    end

    def loadAllClasses
      # Returns a classclasses
      parameter = { basic_auth: @auth }

      response = self.class.get("/classes", parameter)

      if response.success?
        # create a class
        classListData = response["ClassConfigurationList"]
        classDefinitions = Array.new
        classListData.each do |classData|
          classDefinitions.push ClassDefinition.new(classData)
        end
        classDefinitions
       else
         logger.warn "Could not load a classlist #{response.response}"
      end
    end

  end
end
