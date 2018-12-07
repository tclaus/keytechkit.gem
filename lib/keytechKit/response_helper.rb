module KeytechKit
  # Helps with common responses
  class ResponseHelper
    # Returns a success object with success:true / false. If false
    # it also adds the x-errordescription object from keytech API
    def self.success(response)
      if response.success?
        { success: true }
      else
        { success: false, error: response.headers['x-errordescription'].to_s }
      end
    end

    # Returns a success object with success:true/false. If true
    # it adds a ID parameter extracted from the location header.
    # If false it adds a error response text
    def self.created_with_location(response)
      if response.success?
        { success: true,
          id: response.headers['location'] }
      else
        { success: false, error: response.headers['x-errordescription'].to_s }
      end
    end
  end
end
