require 'keytechKit/elements/element'

module KeytechKit
  # Represents the header from search results
  class SearchResponseHeader

    attr_accessor :pageNumber
    attr_accessor :pageSize
    attr_accessor :totalRecords
    attr_accessor :elementList # list of elements
    attr_accessor :keytechkit

    def initialize(keytechkit, response)
      @keytechkit = keytechkit
      parseResponse(response)

    end

    private

    def parseResponse(response)
      @pageNumber = response["PageNumber"]
      @pageSize = response["PageSize"]
      @totalRecords = response["Totalrecords"]
      @elementList = parseElementList(response["ElementList"])
    end

    def parseElementList(elementResults)
      elements  = Array.new
      elementResults.each do |elementData|
        element = Element.new(@keytechkit, elementData)
        elements.push element
      end
      @elementList = elements
    end

  end
end
