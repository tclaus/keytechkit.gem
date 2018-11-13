require 'keytechKit/elements/data_dictionary/data_dictionary_definition'

module KeytechKit
  class DataDictionaryHandler
    include HTTParty
    default_timeout 10
    attr_accessor :keytechkit

    def initialize(keytechkit, base_url, username, password)
      self.class.base_uri(base_url)
      @auth = { username: username, password: password }
      @keytechkit = keytechkit
    end

    def getDefinition(datadictionary_id)
      # /DataDictionaries/{ID}|{Name}
      parameter = { basic_auth: @auth }

      response = self.class.get("/datadictionaries/#{datadictionary_id}", parameter)
      if response.success?
        parse_dataDictionaryDefinition(response['AttributeDefinition'])
      else
        raise response.response
      end
    end

    # Returns a hashed value with data
    def getData(datadictionary_id)
      # /DataDictionaries/{ID}|{Name}/data
      parameter = { basic_auth: @auth }

      response = self.class.get("/datadictionaries/#{datadictionary_id}/data", parameter)
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
        definition.push DataDictionaryDefinition.new(definitionData)
      end
      definition
    end
  end
end
