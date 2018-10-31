require 'keytechKit/elements/bom/bomElement'

module KeytechKit
  class BillOfMaterial
    attr_accessor :bomElementList
    attr_accessor :pageNumber
    attr_accessor :pageSize
    attr_accessor :totalRecords

    def initialize(response_data)
      parseBomData(response_data)
    end

    private

    def parseBomData(response_data)
      self.pageNumber = response_data['PageNumber']
      self.pageSize = response_data['PageSize']
      self.totalRecords = response_data['TotalRecords']

      self.bomElementList = []
      response_data['BomElementList'].each do |bom_data|
        bomElementList.push BomElement.new(bom_data)
      end
    end
  end
end
