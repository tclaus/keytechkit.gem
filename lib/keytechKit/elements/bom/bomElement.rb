module KeytechKit
  class BomElement
    attr_accessor :key
    attr_accessor :elementKey
    attr_accessor :keyValueList
    attr_accessor :cadCount
    attr_accessor :cadDriven
    attr_accessor :changedBy
    attr_accessor :changedByLong
    attr_accessor :count
    attr_accessor :createdBy
    attr_accessor :createdByLong
    attr_accessor :displayName
    attr_accessor :element

    def initialize(bomElementData)
      self.key = bomElementData['Key']
      self.elementKey = bomElementData['Element']['Key']
      self.cadCount = bomElementData['CadCount']
      self.cadDriven = bomElementData['CadDriven']
      self.changedBy = bomElementData['ChangedBy']
      self.changedByLong = bomElementData['ChangedByLong']
      self.count = bomElementData['Count']
      self.createdBy = bomElementData['CreatedBy']
      self.createdByLong = bomElementData['CreatedByLong']
      self.displayName = bomElementData['DisplayName']
      # self.element = bomElementData["Element"]
      set_key_value_list(bomElementData['KeyValueList'])
    end

    private

    def set_key_value_list(kvData)
      self.keyValueList = ({})
      kvData.each do |kvPair|
        keyValueList[kvPair['Key'].to_s] = kvPair['Value']
      end
    end
  end
end
