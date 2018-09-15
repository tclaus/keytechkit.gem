require 'keytechKit/tools'
require 'keytechKit/elements/files/file'

module KeytechKit
  class Files
    include HTTParty

    def initialize(base_url, username, password)
      self.class.base_uri(base_url)
      @auth = { username: username, password: password }
    end

    # Returns true or false if a masterfile exist
    def hasMasterfile(elementKey)
      if Tools.classType(elementKey) == "DO" # Only DO Types can have a file
        fileList = load(elementKey)
        fileList.each do |file|
          if file.fileStorageType.downcase == "master"
            return true
          end
        end
      end
      return false
    end

    # Returns information about masterfile
    def masterfileInfo(elementKey)
      if Tools.classType(elementKey) == "DO" # Only DO Types can have a file
        fileList = load(elementKey)
        fileList.each do |file|
          if file.fileStorageType.downcase == "master"
            return file
          end
        end
      end
      return nil
    end


    # Returns the name of a masterfile if present
    def masterfilename(elementKey)
      fileList = load(elementKey)
      fileList.each do |file|
        if file.fileStorageType.downcase! == "master"
          return file.fileName
        end
      end
      return nil
    end

    # Loads the filelist
    # Returns a full list of file data
    def load(elementKey)
      parameter = { basic_auth: @auth }

      response = self.class.get("/elements/#{elementKey}/files", parameter)

      if response.success?
        parse_files(response["FileInfos"])
       else
         raise response.response
      end
    end

    # Loads the masterfile directly
    def loadMasterfile(elementKey)
      parameter = { basic_auth: @auth }
      puts "Loading masterfile..."
      response = self.class.get("/elements/#{elementKey}/files/masterfile", parameter)
      if response.success?
        return response
       else
         raise response.response
      end
    end

private
   def parse_files(filesResult)
     files = Array.new
     filesResult.each do |fileData|
        files.push File.new(fileData)
     end
     files
   end


  end
end
