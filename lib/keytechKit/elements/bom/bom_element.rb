module KeytechKit
  ##
  # A single article of a bill of material list
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

    def initialize(data)
      self.key = data['Key']
      self.elementKey = data['Element']['Key']
      self.cadCount = data['CadCount']
      self.cadDriven = data['CadDriven']
      self.changedBy = data['ChangedBy']
      self.changedByLong = data['ChangedByLong']
      self.count = data['Count']
      self.createdBy = data['CreatedBy']
      self.createdByLong = data['CreatedByLong']
      self.displayName = data['DisplayName']
      # self.element = data["Element"]
      set_key_value_list(data['KeyValueList'])
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
