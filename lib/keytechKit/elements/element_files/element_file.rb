module KeytechKit
  ##
  # A single file representation
  class ElementFile
    attr_accessor :changedAt
    attr_accessor :fileName
    attr_accessor :fileSize
    attr_accessor :fileStorageType
    attr_accessor :fileId

    def initialize(data)
      self.changedAt = data['FileLastChangedAt']
      self.fileSize = data['FileSize']
      self.fileName = data['FileName']
      self.fileId = data['FileID']
      self.fileStorageType = data['FileStorageType']
    end
  end
end
