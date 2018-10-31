
module KeytechKit
  class Serverinfo
    attr_accessor :response

    attr_accessor :database_version
    attr_accessor :api_version
    attr_accessor :server_description
    attr_accessor :server_id

    def initialize(result_data)
      parse_response(result_data)
    end

    def parse_response(result_data)
      result = result_data
      result.each do |kv|
        puts "Key: #{kv['Key']}, #{kv['Value']}"

        case kv['Key']
        when 'keytech database version' then self.database_version = kv['Value']
        when 'API version' then self.api_version = kv['Value']
          # More fields
        end
      end
    end

  end
end
