require 'keytechKit/tools'
require 'keytechKit/elements/elementFiles/elementFile'

module KeytechKit
  class ElementFiles
    include HTTParty

    def initialize(base_url, username, password)
      self.class.base_uri(base_url)
      @auth = { username: username, password: password }
    end

    # Returns true or false if a masterfile exist
    def hasMasterfile(element_key)
      if Tools.classType(element_key) == 'DO' # Only DO Types can have a file
        fileList = load(element_key)
        if !fileList.nil?
          fileList.each do |file|
            if file.fileStorageType.downcase == "master"
              return true
            end
          end
        end
      end
      false
    end

    # Returns information about masterfile
    def masterfileInfo(element_key)
      if Tools.classType(element_key) == 'DO' # Only DO Types can have a file
        fileList = load(element_key)
        if !fileList.nil?
          fileList.each do |file|
            if file.fileStorageType.downcase == 'master'
              return file
            end
          end
        end
      end
      false
    end


    # Returns the name of a masterfile if present
    def masterfilename(element_key)
      fileList = load(element_key)
      if !fileList.nil?
        fileList.each do |file|
          if file.fileStorageType.downcase! == 'master'
            return file.fileName
          end
        end
      end
      ''
    end

    # Loads the filelist
    # Returns a full list of file data
    def load(element_key)
      parameter = { basic_auth: @auth }

      response = self.class.get("/elements/#{element_key}/files", parameter)

      if response.success?
        parse_files(response["FileInfos"])
      end
    end

    # Loads the masterfile directly
    def loadMasterfile(element_key)
      parameter = { basic_auth: @auth }
      puts "Loading masterfile..."
      response = self.class.get("/elements/#{element_key}/files/masterfile", parameter)
      if response.success?
        return response
      end
    end

    def uploadMasterFile(element_key, file, original_filename)
      # file, elementkey , name??
      content_length = file.size

      parameter = { basic_auth: @auth,
        headers: { 'Content-Type' => 'application/json',
                 'Content-Length' => "#{content_length}",
                    'storageType' => 'MASTER',
                       'filename' => "#{original_filename}"
                    },
        body: file.read
      }

      response = self.class.post("/elements/#{element_key}/files",parameter)
      if response.success?
        return { success: true, location: response.headers['location'].to_s }
      else
        return { success: false, error: response.headers['x-errordescription'].to_s }
      end
    end

private
   def parse_files(filesResult)
     files = Array.new
     filesResult.each do |fileData|
        files.push ElementFile.new(fileData)
     end
     files
   end
  end
end
