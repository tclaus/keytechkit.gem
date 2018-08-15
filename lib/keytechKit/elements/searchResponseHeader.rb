require 'keytechKit/elements/element'

# Represents the header from search results
class SearchResponseHeader

  attr_accessor :pageNumber
  attr_accessor :pageSize
  attr_accessor :totalRecords
  attr_accessor :elementList # list of elements

  def initialize(response)
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
      element = Element.new(elementData)
      elements.push element
    end
    @elementList = elements
  end

end
