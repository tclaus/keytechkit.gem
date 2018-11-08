module KeytechKit
  ##
  # A key - values list that conatins a Name and a list of values
  # 
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
