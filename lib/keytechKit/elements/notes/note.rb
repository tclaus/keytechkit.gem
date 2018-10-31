module KeytechKit
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

    def initialize(noteData)
      self.changedAt = noteData['ChangedAt']
      self.changedBy = noteData['ChangedBy']
      self.changedByLong = noteData['ChangedByLong']

      self.createdAt = noteData['CreatedAt']
      self.createdBy = noteData['CreatedBy']
      self.createdByLong = noteData['CreatedByLong']

      self.id = noteData['ID']
      self.noteType = noteData['NoteType']
      self.subject = noteData['Subject']
      self.text = noteData['Text']
    end
  end
end
