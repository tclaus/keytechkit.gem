require 'keytechKit/elements/element'
require 'keytechKit/elements/group_by'
module KeytechKit
  ##
  # Represents the header from search results
  #
  class SearchResponseHeader
    attr_accessor :pageNumber
    attr_accessor :pageSize
    attr_accessor :totalRecords
    attr_accessor :elementList # list of elements
    attr_accessor :groupBy

    def initialize(response)
      parseResponse(response)
    end

    private

    def parseResponse(response)
      @pageNumber = response['PageNumber']
      @pageSize = response['PageSize']
      @totalRecords = response['Totalrecords']
      @elementList = parseElementList(response['ElementList'])
      @groupBy = parseGroupBy(response['GroupBy'])
    end

    def parseGroupBy(groupByResults)
      if groupByResults
        groupByArray = []
        groupByResults.each do |groupBy|
          groupByArray.push GroupBy.new(groupBy)
        end
        groupByArray.first
      end
    end

    def parseElementList(elementResults)
      elements = []
      elementResults.each do |elementData|
        element = Element.new(elementData)
        elements.push element
      end
      @elementList = elements
    end
  end
end
