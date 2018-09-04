
module KeytechKit
  class Element

  attr_accessor :key #unique key of this element
  attr_accessor :name

  # a array of {key:, value:} pairs
  attr_accessor :keyValueList

  attr_accessor :createdByLong
  attr_accessor :createdBy
  attr_accessor :createdAt

  attr_accessor :changedAt
  attr_accessor :changedByLong
  attr_accessor :changedBy

  attr_accessor :displayname #localized DisplayName
  attr_accessor :thumbnailHint
  attr_accessor :hasVersions
  attr_accessor :classDisplayName
  attr_accessor :status
  attr_accessor :version
  attr_accessor :description

  def initialize(elementData)
    self.key = elementData["Key"]
    self.name = elementData["Name"]
    set_key_value_list(elementData["KeyValueList"])

    self.displayname = elementData["DisplayName"]
    self.classDisplayName = elementData["ClassDisplayName"]
    self.version = elementData["Version"]
    self.status = elementData["Status"]
    self.description = elementData["Description"]

    self.changedBy = elementData["ChangedBy"]
    self.changedByLong = elementData["ChangedByLong"]
    self.changedAt = elementData["ChangedAt"]

    self.createdBy = elementData["CreatedBy"]
    self.createdByLong = elementData["CreatedByLong"]
    self.createdAt = elementData["CreatedAt"]

    self.thumbnailHint = elementData["ThumbnailHint"]
    self.hasVersions = elementData["HasVersions"]
  end

  private
   def set_key_value_list(kvData)
     self.keyValueList =  Hash.new
     kvData.each do |kvPair|
        self.keyValueList[kvPair["Key"].to_s] = kvPair["Value"]
     end

   end

  end
end
