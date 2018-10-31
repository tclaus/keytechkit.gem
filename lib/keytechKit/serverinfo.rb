
module KeytechKit
  class Serverinfo
    include HTTParty
    attr_accessor :response

    attr_accessor :database_version
    attr_accessor :api_version
    attr_accessor :server_description
    attr_accessor :server_id

    def initialize(base_url)
      self.class.base_uri(base_url)
    end

    def self.load(base_url)
      serverinfo = new(base_url)
      serverinfo.get_serverinfo
    end

    def get_serverinfo
      response = self.class.get('/serverinfo')
      if response.success?
        self.response = response
        parse_response

      else
        raise response.response
      end
    end

    private

    def parse_response
      result = response['ServerInfoResult']
      result.each do |kv|
        puts "Key: #{kv['Key']}, #{kv['Value']}"
        case kv['Key']
        when 'keytech database version' then self.database_version = kv['Value']
        when 'API version' then self.api_version = kv['Value']
        end
      end
      self
    end
  end
end
