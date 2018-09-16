require 'keytechKit/elements/bom/bomElement'

module KeytechKit
  class BillOfMaterial

    attr_accessor :bomElementList
    attr_accessor :pageNumber
    attr_accessor :pageSize
    attr_accessor :totalRecords

    def initialize(responseData)
          parseBomData(responseData)
    end

    private
    def parseBomData(responseData)
      self.pageNumber = responseData["PageNumber"]
      self.pageSize = responseData["PageSize"]
      self.totalRecords = responseData["TotalRecords"]

      self.bomElementList = Array.new
      responseData["BomElementList"].each do |bomElementData|
        self.bomElementList.push BomElement.new(bomElementData)
      end

    end
  end
end
