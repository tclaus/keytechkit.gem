module KeytechKit
  class Subarea
    attr_accessor :displayname
    attr_accessor :key

    def initialize(data)
      puts "Subarea: #{data}"
      self.displayname = data["DisplayText"]
      self.key = data["Key"]
    end

  end
end
