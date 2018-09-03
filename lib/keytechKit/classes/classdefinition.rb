require 'keytechKit/classes/subarea'

module KeytechKit

  class ClassDefinition
    attr_accessor :classKey
    attr_accessor :attributesList
    attr_accessor :displayname
    attr_accessor :availableSubareas
    attr_accessor :hasNumberGenerator
    attr_accessor :Listers

    def initialize(classData)
      self.classKey = classData["ClassKey"]
      self.displayname = classData["Displayname"]
      self.attributesList = classData["AttributesList"]
      self.availableSubareas = loadSubAreas(classData["AvailableSubAreas"])
      self.attributesList = classData["AttributesList"]
      self.hasNumberGenerator = classData["HasNumberGenerator"]

      # TODO: Attributeslist parsing

    end

private
  def loadSubAreas(subareasResult)
    subAreas  = Array.new
    subareasResult.each do |subareaResult|
      subArea = Subarea.new(subareaResult)
      subAreas.push subArea
    end
    subAreas
  end

  end
end
