module KeytechKit
  ##
  # A single note
  class Note
    attr_accessor :changedAt
    attr_accessor :changedBy
    attr_accessor :changedByLong
    attr_accessor :createdAt
    attr_accessor :createdBy
    attr_accessor :createdByLong
    attr_accessor :id
    attr_accessor :noteType
    attr_accessor :subject
    attr_accessor :text

    def initialize(data)
      self.changedAt = data['ChangedAt']
      self.changedBy = data['ChangedBy']
      self.changedByLong = data['ChangedByLong']

      self.createdAt = data['CreatedAt']
      self.createdBy = data['CreatedBy']
      self.createdByLong = data['CreatedByLong']

      self.id = data['ID']
      self.noteType = data['NoteType']
      self.subject = data['Subject']
      self.text = data['Text']
    end
  end
end
