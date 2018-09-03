module KeytechKit
  class Control
    attr_accessor :attributeAlignment
    attr_accessor :attributeName
    attr_accessor :controlType
    attr_accessor :dataDictionaryID
    attr_accessor :dataDictionaryType
    attr_accessor :defaultValue
    attr_accessor :displayname
    attr_accessor :font
    attr_accessor :isEditable
    attr_accessor :isNullable
    attr_accessor :name
    attr_accessor :position
    attr_accessor :sequence
    attr_accessor :size

    def initialize(data)
      self.attributeAlignment = data["AttributeAlignment"]
      self.attributeName = data["AttributeName"]
      self.controlType = data["ControlType"]
      self.dataDictionaryID = data["DataDictionaryID"]
      self.dataDictionaryType = data["DataDictionaryType"]
      self.defaultValue = data["DefaultValue"]
      self.displayname = data["Displayname"]
      self.font = data["Font"]
      self.isEditable = data["IsEditable"]
      self.isNullable = data["IsNullable"]
      self.name = data["Name"]
      self.position = data["Position"]
      self.sequence = data["Sequence"]
      self.size = data["Size"]
    end
  end
end
