require 'keytechKit/serverinfo'

module KeytechKit
  ##
  # Serverinfo Handler
  class ServerInfoHandler
    include HTTParty
    default_timeout 10

    def initialize(keytechkit, base_url)
      self.class.base_uri(base_url)
      @keytechkit = keytechkit
    end

    def load
      response = self.class.get('/serverinfo')
      if response.success?
        json = JSON.parse(response.body)
      puts json['ServerInfoResult']
        Serverinfo.new(response['ServerInfoResult'])
      else
        raise response.response
      end
    end
  end
end
