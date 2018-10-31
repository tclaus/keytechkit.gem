require 'keytechKit/elements/dd/ddDefinition'

module KeytechKit
  class DataDictionaries
    include HTTParty

    attr_accessor :keytechkit

    def initialize(keytechkit, base_url, username, password)
      self.class.base_uri(base_url)
      @auth = { username: username, password: password }
      @keytechkit = keytechkit
    end

    def getDefinition(ddID)
      # /DataDictionaries/{ID}|{Name}
      parameter = { basic_auth: @auth }

      response = self.class.get("/datadictionaries/#{ddID}", parameter)
      if response.success?
        parse_dataDictionaryDefinition(response['AttributeDefinition'])
      else
        raise response.response
      end
    end

    # Returns a hashed value with data
    def getData(ddID)
      # /DataDictionaries/{ID}|{Name}/data
      parameter = { basic_auth: @auth }

      response = self.class.get("/datadictionaries/#{ddID}/data", parameter)
      if response.success?
        response['Data']
      else
        raise response.response
      end
    end

    private

    def parse_dataDictionaryDefinition(definitionArray)
      definition = []
      definitionArray.each do |definitionData|
        definition.push DDDefinition.new(definitionData)
      end
      definition
    end
  end
end
