
module KeytechKit
  class DDDefinition
    attr_accessor :attribute
    attr_accessor :toTargetAttribute
    attr_accessor :displayText

    def initialize(noteData)
      self.attribute = noteData['Attribute']
      self.toTargetAttribute = noteData['ToTargetAttribute']
      self.displayText = noteData['Displaytext']
    end
  end
end
