module KeytechKit

  class File
    attr_accessor :changedAt
    attr_accessor :fileName
    attr_accessor :fileSize
    attr_accessor :fileStorageType
    attr_accessor :fileId

    def initialize(fileData)
      self.changedAt = fileData["FileLastChangedAt"]
      self.fileSize = fileData["FileSize"]
      self.fileName = fileData["FileName"]
      self.fileId = fileData["FileId"]
      self.fileStorageType = fileData["FileStorageType"]

    end

  end
end
