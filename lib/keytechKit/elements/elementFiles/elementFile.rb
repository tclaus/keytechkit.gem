module KeytechKit
  class ElementFile
    attr_accessor :changedAt
    attr_accessor :fileName
    attr_accessor :fileSize
    attr_accessor :fileStorageType
    attr_accessor :fileId

    def initialize(file_data)
      self.changedAt = file_data['FileLastChangedAt']
      self.fileSize = file_data['FileSize']
      self.fileName = file_data['FileName']
      self.fileId = file_data['FileId']
      self.fileStorageType = file_data['FileStorageType']
    end
  end
end
