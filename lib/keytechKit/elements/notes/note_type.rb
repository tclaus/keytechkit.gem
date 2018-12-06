module KeytechKit
  ##
  # A single note
  class NoteType
    attr_accessor :allow_modify
    attr_accessor :displaytext
    attr_accessor :id
    attr_accessor :is_document_info
    attr_accessor :is_folder_info
    attr_accessor :is_masteritem_info
    attr_accessor :is_system_info

    def initialize(data)
      @allow_modify = data['AllowModify']
      @displaytext = data['Displaytext']
      @id = data['ID']
      @is_document_info = data['IsDocumentInfo']
      @is_folder_info = data['IsFolderInfo']
      @is_document_info = data['IsMasterItemInfo']
      @is_system_info = data['IsSystemInfo']
    end
  end
end
