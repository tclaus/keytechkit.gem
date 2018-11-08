require 'keytechKit/elements/bom/bom_element'

module KeytechKit
  ##
  # List of bill of material articles
  class BomElementList
    attr_accessor :bomElementList
    attr_accessor :pageNumber
    attr_accessor :pageSize
    attr_accessor :totalRecords

    def initialize(data)
      parseBomData(data)
    end

    private

    def parseBomData(data)
      self.pageNumber = data['PageNumber']
      self.pageSize = data['PageSize']
      self.totalRecords = data['TotalRecords']

      self.bomElementList = []
      data['BomElementList'].each do |bom_data|
        bomElementList.push BomElement.new(bom_data)
      end
    end
  end
end
