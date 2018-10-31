module KeytechKit
  class GroupBy
    attr_accessor :attributeName
    attr_accessor :attributeDisplayName
    attr_accessor :values

    def initialize(data)
      self.attributeName = data['AttributeName']
      self.attributeDisplayName = data['AttributeDisplayName']
      self.values = data['Values']
    end
  end
end
