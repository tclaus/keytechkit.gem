
module KeytechKit
  ##
  # Represents a single attribute - target attribute relationship
  #
  class DataDictionaryDefinition

    # Data dictionray attribute
    attr_accessor :attribute

    # target attribute to map to
    attr_accessor :toTargetAttribute

    # Localized displaytext
    attr_accessor :displayText

    def initialize(data)
      self.attribute = data['Attribute']
      self.toTargetAttribute = data['ToTargetAttribute']
      self.displayText = data['Displaytext']
    end
  end
end
