class Tools
  # Returns a classkey (MISC_FILE) from a elementkey (MISC_FILE:1234)
  def self.classKey(element_key)
    element_key.split(':').first
  end

  # Return a classkey (MI, FD, DO) from a elementkey (MISC_FILE:!234)
  def self.classType(element_key)
    classKey = self.classKey(element_key)
    return 'MI' if classKey.upcase.end_with?('_MI')
    return 'FD' if classKey.end_with?('_FD', '_WF')
    'DO'
  end
end
