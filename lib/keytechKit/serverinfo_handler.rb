require 'keytechKit/serverinfo'

module KeytechKit
  ##
  # Serverinfo Handler
  class ServerInfoHandler
    include HTTParty

    def initialize(keytechkit, base_url)
      self.class.base_uri(base_url)
      @keytechkit = keytechkit
    end

    def load
      response = self.class.get('/serverinfo')
      if response.success?
        Serverinfo.new(response['ServerInfoResult'])
      else
        raise response.response
      end
    end
  end
end
