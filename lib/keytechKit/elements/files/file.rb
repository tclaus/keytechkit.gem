module KeytechKit

  class File
    attr_accessor :changedAt
    attr_accessor :filename
    attr_accessor :filesize
    attr_accessor :fileStorageType
    attr_accessor :fileId

    def initialize(fileData)
      self.changedAt = fileData["FileLastChangedAt"]
      self.filesize = fileData["FileSize"]
      self.filename = fileData["FileName"]
      self.fileId = fileData["FileId"]
      self.fileStorageType = fileData["FileStorageType"]

    end

  end
end
