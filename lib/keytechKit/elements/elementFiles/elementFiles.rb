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
        file_list = load(element_key)
        unless file_list.nil?
          file_list.each do |file|
            return true if file.fileStorageType.casecmp('master').zero?
          end
        end
      end
      false
    end

    # Returns information about masterfile
    def masterfileInfo(element_key)
      if Tools.classType(element_key) == 'DO' # Only DO Types can have a file
        file_list = load(element_key)
        unless file_list.nil?
          file_list.each do |file|
            return file if file.fileStorageType.casecmp('master').zero?
          end
        end
      end
      false
    end

    # Returns the name of a masterfile if present
    def masterfilename(element_key)
      file_list = load(element_key)
      unless file_list.nil?
        file_list.each do |file|
          return file.fileName if file.fileStorageType.downcase! == 'master'
        end
      end
      ''
    end

    # Loads the filelist
    # Returns a full list of file data
    def load(element_key)
      parameter = { basic_auth: @auth }

      response = self.class.get("/elements/#{element_key}/files", parameter)

      parse_files(response['FileInfos']) if response.success?
    end

    # Loads the masterfile directly
    def loadMasterfile(element_key)
      parameter = { basic_auth: @auth }
      puts 'Loading masterfile...'
      response = self.class.get("/elements/#{element_key}/files/masterfile", parameter)
      return response if response.success?
    end

    # Masterfile is the main file attached to a document
    #
    def uploadMasterFile(element_key, file, original_filename)
      # file, elementkey , name??
      content_length = file.size
      content_type = 'application/octet-stream; charset=utf-8'
      parameter = { basic_auth: @auth,
                    headers: { 'Content-Type' => content_type,
                               'Content-Length' => content_length.to_s,
                               'storageType' => 'MASTER',
                               'filename' => original_filename.to_s },
                    body: file.read }
      upload_file element_key, parameter
    end

    # The preview is a larger preview file. It must not have the same type as the masterfile,
    # But should allow a sneak preview to its contents.
    # e.g.: You have a large (200MB) CAD file, then der prebview may represent a
    # 2D Drawing of the large fole.
    # You can have more than one preview file
    def uploadPreviewFile(element_key, file, original_filename)
      # file, elementkey , name??
      content_length = file.size
      content_type = 'application/octet-stream; charset=utf-8'

      parameter = { basic_auth: @auth,
                    headers: { 'Content-Type' => content_type,
                               'Content-Length' => content_length.to_s,
                               'storageType' => 'PREVIEW',
                               'filename' => original_filename.to_s },
                    body: file.read }
      upload_file element_key, parameter
    end

    # A Quickpreview is mostly a smaller image file. Best is to make a image_file
    # from the quickpreview. Respect modern retina displays - so dont be shy
    # to upload image files of at least 800x600 pixels in size
    def uploadQuickPreviewFile(element_key, file, original_filename)
      # file, elementkey , name??
      content_length = file.size
      content_type = 'application/octet-stream; charset=utf-8'

      parameter = { basic_auth: @auth,
                    headers: { 'Content-Type' => content_type,
                               'Content-Length' => content_length.to_s,
                               'storageType' => 'QUICKPREVIEW',
                               'filename' => original_filename.to_s },
                    body: file.read }
      upload_file element_key, parameter
    end

    private

    def upload_file(element_key, parameter)
      response = self.class.post("/elements/#{element_key}/files", parameter)
      if response.success?
        return { success: true, location: response.headers['location'].to_s }
      else
        return { success: false, error: response.headers['x-errordescription'].to_s }
      end
    end

    def parse_files(filesResult)
      files = []
      filesResult.each do |fileData|
        files.push ElementFile.new(fileData)
      end
      files
    end
  end
end
