module KeytechKit
  ##
  # Provides information about current keytech server
  # Read the full response for raw server data or use the well named accessors
  class Serverinfo
    attr_accessor :response

    attr_accessor :description
    attr_accessor :database_version
    attr_accessor :api_version
    # Unique ServerID this ID is unique for every installation
    attr_accessor :server_id
    attr_accessor :allow_status_change

    def initialize(result_data)
      parse_response(result_data)
    end

    def parse_response(result_data)

      self.response = result_data

      result = result_data
      result.each do |kv|
        case kv['Key']
        when 'Server Description' then self.description = kv['Value']
        when 'keytech database version' then self.database_version = kv['Value']
        when 'API version' then self.api_version = kv['Value']
        when 'ServerID' then self.server_id = kv['Value']
        when 'AllowStatusChange' then self.allow_status_change = kv['Value']

          # More fields
        end
      end
    end
  end
end
