class Tools

  # Returns a classkey (MISC_FILE) from a elementkey (MISC_FILE:1234)
  def self.class_key(element_key)
    element_key.split(':').first
  end

  # Return a classkey (MI, FD, DO) from a elementkey (MISC_FILE:!234)
  def self.class_type(element_key)
    class_key = class_key(element_key)
    return 'MI' if class_key.upcase.end_with?('_MI')

    return 'FD' if class_key.end_with?('_FD', '_WF')

    'DO'
  end
end
