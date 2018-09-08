require 'keytechKit/elements/files/file'

module KeytechKit
  class Files
    include HTTParty

    def initialize(base_url, username, password)
      self.class.base_uri(base_url)
      @auth = { username: username, password: password }
    end

    def hasMasterfile(elementKey)
      fileList = load(elementKey)
      fileList.each do |file|
        if file.fileStorageType.downcase == "master"
          return true
        end
      end
      return false
    end

    def masterfilename(elementKey)
      fileList = load(elementKey)
      fileList.each do |file|
        if file.fileStorageType.downcase! == "master"
          return file.filename
        end
      end
      return "file"
    end

    # Loads the filelist
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
