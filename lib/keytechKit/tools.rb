class Tools

  # Returns a classkey (MISC_FILE) from a elementkey (MISC_FILE:1234)
  def self.classKey(elementKey)
    elementKey.split(":").first
  end

  # Return a classkey (MI, FD, DO) from a elementkey (MISC_FILE:!234)
  def self.classType(elementKey)
    classKey = self.classKey(elementKey)
    if classKey.upcase.end_with?("_MI")
      return "MI"
    end

    if classKey.end_with?("_FD") || classKey.end_with?("_WF")
      return "FD"
    end

    return "DO"
  end
end
