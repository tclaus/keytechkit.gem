require 'keytechKit/tools'
require 'keytechKit/elements/element_files/element_file'

module KeytechKit
  ##
  # Element File handler
  class ElementFileHandler
    include HTTParty
    default_timeout 10

    def initialize(base_url, username, password)
      self.class.base_uri(base_url)
      @auth = { username: username, password: password }
    end

    # Returns true or false if a masterfile exist
    def masterfile?(element_key)
      if Tools.class_type(element_key) == 'DO' # Only DO Types can have a file
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
    def masterfile_info(element_key)
      if Tools.class_type(element_key) == 'DO' # Only DO Types can have a file
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
    def masterfile_name(element_key)
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
    def load_masterfile(element_key)
      parameter = { basic_auth: @auth }
      response = self.class.get("/elements/#{element_key}/files/masterfile", parameter)
      return response if response.success?
    end

    # Masterfile is the main file attached to a document
    #
    def upload_masterfile(element_key, file, original_filename)
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
    def upload_preview(element_key, file, original_filename)
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
    def upload_quickpreview(element_key, file, original_filename)
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

    def remove_masterfile(element_key)
      file_list = load(element_key)
      if !file_list.nil?
        file_list.each do |file|
          return remove_file(element_key, file.fileId) if file.fileStorageType.casecmp('master').zero?
        end
      end
      { success: true, message: "No file found" }
    end

    def remove_preview(element_key)
      file_list = load(element_key)
      if !file_list.nil?
        file_list.each do |file|
          return remove_file(element_key, file.fileId) if file.fileStorageType.casecmp('preview').zero?
        end
      end
      { success: true, message: "No file found" }
    end

    def remove_quickpreview(element_key)
      file_list = load(element_key)
      if !file_list.nil?
        file_list.each do |file|
          return remove_file(element_key, file.fileId) if file.fileStorageType.casecmp('quickpreview').zero?
        end
      end
      { success: true, message: "No file found" }
    end

    private

    def remove_file(element_key, file_id)
      parameter = { basic_auth: @auth }
      response = self.class.delete("/elements/#{element_key}/files/#{file_id}", parameter)
      if response.success?
        { success: true }
      else
        { success: false, error: response.headers['x-errordescription'].to_s }
      end
    end

    def upload_file(element_key, parameter)
      response = self.class.post("/elements/#{element_key}/files", parameter)
      parse_response(response)
    end

    def parse_response(response)
      if response.success?
        { success: true, location: response.headers['location'].to_s }
      else
        { success: false, error: response.headers['x-errordescription'].to_s }
      end
    end

    def parse_files(files_result)
      files = []
      files_result.each do |file_data|
        files.push ElementFile.new(file_data)
      end
      files
    end
  end
end
