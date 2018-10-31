module KeytechKit
  class Targetlink
    attr_accessor :entryName
    attr_accessor :linkID
    attr_accessor :parentID
    attr_accessor :targetElementKey

    def initialize(result)
      parse_result(result)
    end

    private

    def parse_result(result)
      self.entryName = result['EntryName']
      self.linkID = result['LinkID']
      self.parentID = result['ParentID']
      self.targetElementKey = result['TargetElementKey']
    end
  end
end
